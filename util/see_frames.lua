local displayFunction = nil

local ok = pcall(function () require "qt" end)
if qt then
   require 'image'
   local win = nil
   displayFunction = function (frame)
      win = image.display({image=frame, win=win})
   end
else
   print('Could not find qt. Maybe you did not run me using "qlua"')
   print('Trying gfx.js visualizaton')
   local ok, gfx = pcall(function () return require "gfx.js" end)
   if ok then      
      print('Found gfx.js, using gfx visualization, displaying first 100 frames')
      local win = nil
      local imgtable = {}
      displayFunction = function(frame)
	 if #imgtable <= 100 then table.insert(imgtable, frame) end
	 if #imgtable == 100 then win = gfx.image(imgtable, {win=win}); end
      end
   else
      error('Run this script either with qlua or with gfx.js')
   end
end

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

    for i = 1, frames:size(1) do
       displayFunction(frames[i])
    end
end

main()
