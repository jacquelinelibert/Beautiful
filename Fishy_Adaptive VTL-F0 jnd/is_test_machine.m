function b = is_test_machine()

[c, s] = system('hostname');
if strcmp(strtrim(s), 'hoogglans')==0
    b = 1;
else
    b = 0;
end 