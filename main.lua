-----------------------------
-- Auto AWD Framework
-- Au: SJoshua
-----------------------------
function execute(cmd)
    os.execute(cmd .. " >tmp 2> err")
    local f = io.open("tmp", "r")    
    local s = f:read("*a")
    f:close()
    return s or ""
end

dofile("config.lua")
dofile("attack.lua")

local socket = require("socket")

flags = {}

function new_round()
    for cid = 1, #attack do -- challenges
        io.write("[-] challenge ", cid, "\n")
        local cnt = 0
        for tid = config.min_target_id, config.max_target_id do -- targets
            for mid, method in pairs(attack[cid]) do -- methods
                local flag = config.match_flag(method(tid)) -- attack tid and match flag
                if flag then
                    if (flags[flag] == nil) then
                        io.write("[+] #", cid, "\t", flag, "\n")
                        if tid == config.my_team_id then
                            io.write("[!] hacked! \n")
                        else
                            local info
                            flags[flag], info = config.submit_flag(cid, flag)
                            if (flags[flag]) then
                                io.write("[*] submitted successfully! \n")
                            else
                                io.write("[-] invalid flag - ", tostring(info), "\n")
                            end
                        end
                    end
                end 
            end
        end
        io.write("[!] submitted ", cnt, " flag(s) successfully.\n")
    end
end

function main()
    local r_cnt = 0;
    while true do
        r_cnt = r_cnt + 1
        io.write("[-] round ", r_cnt, " start.\n")
        local status, err = pcall(new_round)
        if (not status) then
            io.write("[!] fatal error: ", err, "\n")
        end
        status, err = pcall(dofile, "attack.lua")
        if (not status) then
            io.write("[!] something is wrong with attack modules: ", err, "\n")
        end
        socket.sleep(config.round_gap)
    end
end

main()
