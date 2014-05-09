require 'nn'
local alewrap = require 'alewrap'

torch.manualSeed(0x123456789)
math.randomseed(0x123456789)

local romDir = 'roms/'
local numSamplesPerGame = 100000
local probAccept = 0.01

-- edge detection
local MAX_INTENSITY = 255
local edgeNetwork = nn.SpatialConvolution(1, 1, 2, 2)
edgeNetwork.weight:copy(torch.Tensor({
    -- The Robert's Cross operator is used to detect the edges.
    -- http://homepages.inf.ed.ac.uk/rbf/CVonline/LOCAL_COPIES/OWENS/LECT6/node2.html

        -- Filter 1
        {{
            {MAX_INTENSITY + 1, 1},
            {-1, -(MAX_INTENSITY + 1)},
        }},
    }))
edgeNetwork.bias:zero()

function edgeDetector(input)
    input:resize(1, input:size(1), input:size(2))
    local output = edgeNetwork:forward(input)
    output:apply(function (x)
            if x ~= 0 then
                return 1
            end
            return 0
        end)
    return output
end

local name = assert(arg[1], "Usage: %prog GAME_NAME")
local romPath = romDir .. name .. '.bin'
if not paths.filep(romPath) then
    io.stderr:write(string.format("Missing a ROM file: %s\n", romPath))
    os.exit(1)
end

local env = alewrap.createEnv(romPath, {})
env:envStart()
local actions = env:actions():storage():totable()
local action = {torch.Tensor(1)}

function sample()
    local pixels
    while true do
        action[1][1] = actions[math.random(1, #actions)]
        local reward, observe = env:envStep(action)
        if torch.rand(1)[1] < probAccept then
            pixels = edgeDetector(observe[1]:double())
            break
        end
    end
    return pixels
end

io.write(name .. ' ')
local binfile = io.open(string.format('%s.bin', name), 'w')
for ii = 1,numSamplesPerGame do
    local samp = sample()
    if ii == 1 then
        print('frame size:', unpack(samp:size():totable()))
    end
    io.write('.')
    io.flush()

    samp:apply(function(pixel)
        binfile:write((pixel == 1 and "\1") or "\0")
    end)
    samp = nil
    collectgarbage()
end
binfile:close()


