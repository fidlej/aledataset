
require 'image'

local function loadFrames(path)
    local nRows = 209
    local nCols = 159

    local frameStore = torch.ByteStorage(path)
    local frames = torch.ByteTensor(frameStore)
    local nFrames = frames:nElement() / (nRows * nCols)
    assert(nFrames == math.floor(nFrames), "unexpected frame size")
    frames:resize(nFrames, 1, nRows, nCols)
    return frames
end

local function main()
    local path = arg[1] or "pong-train.bin"
    print("Loading frames:", path)
    local frames = loadFrames(path)
    print("size:", frames:size())

    local win
    for i = 1, frames:size(1) do
        win = image.display({image=frames[i], win=win})
    end
end

main()
