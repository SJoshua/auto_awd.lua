-----------------------------
-- Configuration
-----------------------------

config = {
    min_target_id = 1,
    max_target_id = 30,
    my_team_id = 9,
    round_gap = 10, -- seconds
    submit_gap = 2, -- seconds
    
    -----------------------------
    -- match_flag(str)
    -- str: string
    -- ret: flag string
    -----------------------------
    match_flag = function (str)
        if (type(str) == "string") then
            return str:match("flag{" .. string.rep("[%a%d%-]", 36) .. "}")
        end
    end,

    -----------------------------
    -- submit_flag(cid, flag)
    -- cid: challenge id
    -- flag: string
    -- ret: success (bool), err (string)
    -----------------------------
    submit_flag = function (cid, flag)
        res = execute(string.format([[curl 'http://39.100.119.37:8080/api/v1/challenges/attempt' -H 'Connection: keep-alive' -H 'Accept: application/json' -H 'CSRF-Token: {HIDDEN}' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.122 Safari/537.36' -H 'Content-Type: application/json' -H 'Origin: http://39.100.119.37:8080' -H 'Referer: http://39.100.119.37:8080/challenges' -H 'Accept-Language: zh-CN,zh;q=0.9,en;q=0.8,zh-TW;q=0.7,en-GB;q=0.6,en-US;q=0.5,ja;q=0.4' -H 'Cookie: session={HIDDEN}' --data-binary '{"challenge_id":%d,"submission":"%s"}' --compressed --insecure]], cid, flag))
        if (res:find("Correct")) then
            return true
        else
            if (res:find("Incorrect")) then
                return false, "incorrect"
            elseif (res:find("Do not submit again")) then
                return false, "duplicate"
            elseif (res:find("Slow down")) then
                return false, "limited"
            else 
                return false, res
            end
        end
    end
}