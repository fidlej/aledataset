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


Any bugs can be reported to ivo@danihelka.net
