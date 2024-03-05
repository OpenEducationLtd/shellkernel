#include <stdio.h>
#include <stdlib.h>
#include <git2.h>

int main() {
    int error;
    git_repository *repo;
    git_remote *remote;
    git_remote_callbacks callbacks = GIT_REMOTE_CALLBACKS_INIT;
    const char *url = "https://github.com/immersive-systems/Qemu18.git";

    error = git_repository_open(&repo, ".");
    if (error < 0) {
        fprintf(stderr, "Error initializing repository: %s\n", giterr_last()->message);
        exit(1);
    }

    error = git_remote_load(&remote, repo, "origin");
    if (error < 0) {
        fprintf(stderr, "Error loading remote: %s\n", giterr_last()->message);
        exit(1);
    }

    callbacks.transfer_progress = my_transfer_progress_cb;
    error = git_remote_connect(remote, GIT_DIRECTION_FETCH, &callbacks, NULL);
    if (error < 0) {
        fprintf(stderr, "Error connecting to remote: %s\n", giterr_last()->message);
        exit(1);
    }

    error = git_remote_download(remote, NULL, NULL, &callbacks, NULL);
    if (error < 0) {
        fprintf(stderr, "Error downloading from remote: %s\n", giterr_last()->message);
        exit(1);
    }

    git_remote_free(remote);
    git_repository_free(repo);

    return 0;
}

int my_transfer_progress_cb(const git_transfer_progress *stats, void *payload) {
    printf("Received %d bytes, %d bytes total\n", stats->received_objects, stats->total_objects);
    return 0;
}
