-- global autorun flag
_G.AutoRun = false

-- ask a yes or no question to continue or halt script.
-- if autorun is enabled, it will always return true.
--
-- `[yY]` to confirm
-- `[qQ]` to abort
-- any other input will return false
---@param str string question to ask
function AskBeforeContinue(str)
  -- don't ask and continue
  if _G.AutoRun then
    return true
  end
  -- ask
  io.write(str .. " (y/n) : ")
  local input = io.read()
  -- quit script w q
  if string.match(input, "[qQ]") then
    print("aborting installation.")
    os.exit(0)
  end
  -- otherwise return response
  if not string.match(input, "[yY]") then
    return false
  end
  return true
end
