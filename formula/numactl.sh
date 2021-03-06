package set summary "NUMA support for Linux"
package set src.git "https://github.com/numactl/numactl.git"
package set src.url "https://github.com/numactl/numactl/releases/download/v2.0.14/numactl-2.0.14.tar.gz"
package set src.sum "826bd148c1b6231e1284e42a4db510207747484b112aee25ed6b1078756bcff6"
package set bsystem "configure"

# sys/shm.h:
# void* shmat(int __shm_id, const void* __addr, int __flags) __INTRODUCED_IN(26);
# int shmctl(int __shm_id, int __cmd, struct shmid_ds* __buf) __INTRODUCED_IN(26);
# int shmdt(const void* __addr) __INTRODUCED_IN(26);
# int shmget(key_t __key, size_t __size, int __flags) __INTRODUCED_IN(26);
package set sdk.api 26

prepare() {
    sed_in_place 's/-lrt//' Makefile.in
}
