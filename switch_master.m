function [] = switch_master()

cd C:/Users/Zato/Desktop/AMMO/switch;
select = input('0:Exit\n1:strat_full_log\n2:db_full_log\n3:strat_full\n4:db_full\n\nEnter Choice = ');
switch select

case 0
        exit

case 1
    cd C:/Users/Zato/Desktop/AMMO/strat/;
    strat_ammo_full_log();
    select_1 = input('0:Exit\n1:Menu\n\nExit or Menu = ');
    switch select_1
        case 0
            exit
        case 1
            switch_master();
        otherwise
            display('invalid choice');
            switch_master();
    end
    
case 2
    cd C:/Users/Zato/Desktop/AMMO/db/;
    db_ammo_full_log();
    select_2 = input('0:Exit\n1:Menu\n\nExit or Menu = ');
    switch select_2
        case 0
            exit
        case 1
            switch_master();
        otherwise
            display('invalid choice');
            switch_master();
    end
    
case 3
    cd C:/Users/Zato/Desktop/AMMO/strat/;
    strat_ammo_full();
    select_3 = input('0:Exit\n1:Menu\n\nExit or Menu = ');
    switch select_3
        case 0
            exit
        case 1
            switch_master();
        otherwise
            display('invalid choice');
            switch_master();
    end
    
case 4
    cd C:/Users/Zato/Desktop/AMMO/db/;
    db_ammo_full;
    select_4 = input('0:Exit\n1:Menu\n\nExit or Menu = ');
    switch select_4
        case 0
            exit
        case 1
            switch_master();
        otherwise
            display('invalid choice');
            switch_master();
    end

otherwise
    display('invalid choice');
    switch_master();

end
end

        