Producing of the dataset
========================
1) Get [Torch](http://torch.ch/)

2) Put atari ROMs for freeway, pong, riverraid, seaquest, space_invaders
   under `roms/`

   SHA1 sums of the supported ROM files:

    91cc7e5cd6c0d4a6f42ed66353b7ee7bb972fa3f  roms/freeway.bin
    1ffe89d79d55adabc0916b95cc37e18619ef7830  roms/pong.bin
    40329780402f8247f294fe884ffc56cc3da0c62d  roms/riverraid.bin
    7324a1ebc695a477c8884718ffcad27732a98ab0  roms/seaquest.bin
    31d9668fe5812c3d2e076987ca327ac6b2e280bf  roms/space_invaders.bin

3) Build [Arcade Learning Environment](http://www.arcadelearningenvironment.org/)

    ./build_ale.sh

4) Build the Lua wrapper for the Arcade Learning Environment.

    ./build_alewrap.sh

5) Produce the frames.

    ./produce_dataset.sh

6) See some produced frames.

    qlua util/see_frames.lua freeway-train.bin

7) Check the SHA1 sums of the produced files.

    sha1sum *.bin


Expected SHA1 sums
==================

    9dff04e66298e9e74986ce75c3fc0f34709ba40b  freeway-test.bin
    3365f7fb0982477f6c9d437e05002f6c89e6c6bc  freeway-train.bin
    0e5cca074dfa1f5904ba472d9ec9b802a284f9a8  pong-test.bin
    40a14f4dc8b5af5e0cb91e9553c7c6af4bf19fad  pong-train.bin
    24cf49282bc9053aa97ac060e3cc3d311778a6c6  riverraid-test.bin
    b8171b85ca8907a6a43e8096345247a3b9973af2  riverraid-train.bin
    206b95a3b05510cc97e2b9134bfd669b17e95436  seaquest-test.bin
    faf4545c7c0f70a1bcd7e48760cc3ed13319a4f9  seaquest-train.bin
    37fcf64c8233ccb24e01385c97576ca523a9fc96  space_invaders-test.bin
    788390ecc604098b063a67c75b5b924812c42ab9  space_invaders-train.bin


Any bugs can be reported to ivo@danihelka.net
