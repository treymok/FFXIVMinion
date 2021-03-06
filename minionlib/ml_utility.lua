-- flips a table so keys become values
function table_invert(t)
   local s={}
   for k,v in pairs(t) do
     s[v]=k
   end
   return s
end

-- takes in a % number and gives back a random number near that value, for randomizing skill usage at x% hp
function randomize(val)
	if ( val <= 100 and val > 0) then
		local high,low
		if ( (val + 15) > 100) then
			high = 100			
		else
			high = val + 15
		end
		if ( (val - 15) <= 0) then
			low = 1			
		else
			low = val - 15
		end
		return math.random(low,high)
	end
	return 0
end

function PathDistance(posTable)
	if ( TableSize(posTable) > 0) then
		local distance = 0
		local id1, pos1 = next(posTable)
		if (id1 ~= nil and pos1 ~= nil) then
			local id2, pos2 = next(posTable, id1)
			if (id1 ~= nil and pos2 ~= nil) then
				while (id2 ~= nil and pos2 ~= nil) do
					local posDistance = math.sqrt(math.pow(pos2.x-pos1.x,2) + math.pow(pos2.y-pos1.y,2) + math.pow(pos2.z-pos1.z,2))
					distance = distance + posDistance
					pos1 = pos2
					id2, pos2 = next(posTable,id2)
				end
			end
		end
		return distance
	end
end

function FileExists(file)
  local f = fileread(file)
  if ( TableSize(f) > 0) then
    return true
  end
  return false 
end

function LinesFrom(file)
	lines = fileread(file)  
  return lines 
end


function StringSplit(s,sep)
	local lasti, done, g = 1, false, s:gmatch('(.-)'..sep..'()')
	return function()
		if done then return end
		local v,i = g()
		if s == '' or sep == '' then done = true return s end
		if v == nil then done = true return s:sub(lasti) end
		lasti = i
		return v
	end
end

function ApproxEqual(num1, num2)
    return math.abs(math.abs(num1) - math.abs(num2)) < .000001
end

function TableContains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

function ValidTable(table)
    return table ~= nil and TableSize(table) > 0
end

--psuedo enum values for task classes
TS_FAILED = 0
TS_SUCCEEDED = 1
TS_PROGRESSING = 2

TP_IMMEDIATE = 0
TP_ASAP = 1

IMMEDIATE_GOAL = 1
REACTIVE_GOAL = 2
LONG_TERM_GOAL = 3