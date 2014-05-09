if not torch.data then
    require 'torchffi'
end

local function loadFrames(path)
    local nRows = 209
    local nCols = 159

    local frameStore = torch.ByteStorage(path)
    local frames = torch.ByteTensor(frameStore)
    local nFrames = frames:nElement() / (nRows * nCols)
    assert(nFrames == math.floor(nFrames), "unexpected frame size")
    frames:resize(nFrames, nRows, nCols)
    return frames
end

local function saveBytes(path, tensor)
    assert(torch.typename(tensor) == "torch.ByteTensor", "expecting a ByteTensor")
    assert(tensor:isContiguous(), "expecting a contiguous tensor")
    local flatTensor = tensor.new(tensor):resize(tensor:nElement())
    local bufferSize = 8*1024
    local output = assert(io.open(path, 'w'))
    for startIndex = 1, tensor:nElement(), bufferSize do
        local includedEnd = math.min(tensor:nElement(), startIndex + bufferSize - 1)
        local flatView = flatTensor[{{startIndex, includedEnd}}]
        local bytes = ffi.string(torch.data(flatView), flatView:nElement())
        output:write(bytes)
    end
    output:close()
end

local function getShuffled(examples)
    local perm = torch.randperm(examples:size(1))
    local shuffled = examples:clone()
    for i = 1, examples:size(1) do
        shuffled[i]:copy(examples[perm[i]])
    end
    return shuffled
end

local function splitSet(allExamples, nTestFrames)
    local trainingExamples = allExamples[{{1, allExamples:size(1) - nTestFrames}}]
    local testExamples = allExamples[{{allExamples:size(1) - nTestFrames + 1, allExamples:size(1)}}]
    assert(testExamples:size(1) == nTestFrames, "wrong number of test examples")
    return trainingExamples, testExamples
end

local function main()
    torch.manualSeed(1)
    for _, game in ipairs({"freeway", "pong", "riverraid", "seaquest", "space_invaders"}) do
        print("Loading:", game)
        local file = string.format("%s.bin", game)
        local frames = loadFrames(file)
        local shuffled = getShuffled(frames)
        local train, test = splitSet(shuffled, 10000)

        saveBytes(string.format("%s-train.bin", game), train)
        saveBytes(string.format("%s-test.bin", game), test)
    end
end

main()
