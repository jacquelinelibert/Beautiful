function [G, bigFish, tFish, yFish, rFish] = setUpGame


    %% introduce the animation bit
    % Start a new Game
    G = SpriteKit.Game.instance('Title','Interactive Demo','Size',[800 600]);
%     G = SpriteKit.Game.instance('Title','Interactive Demo','Size',[1378 886]);
%     bkg = SpriteKit.Background('img/fishTankBackground.jpg');
    bkg = SpriteKit.Background('img/BACKGROUND.png');
%     bkg.Scale = 1;

    addBorders(G);
    % Setup the SpriteS
    bigFish = SpriteKit.Sprite('fishOne');
    bigFish.initState('swimLeft1','img/L_fish_a.png',true);
    bigFish.initState('swimLeft2','img/L_fish_b.png',true);
    bigFish.initState('swimLeft3','img/L_fish_a.png',true);
    bigFish.initState('swimLeft4','img/L_fish_c.png',true);
    bigFish.initState('swimRight1','img/R_fish_a.png',true);
    bigFish.initState('swimRight2','img/R_fish_b.png',true);
    bigFish.initState('swimRight3','img/R_fish_a.png',true);
    bigFish.initState('swimRight4','img/R_fish_c.png',true);
    bigFish.Scale = 1;
    bigFish.State = 'swimRight1';
    % Add pertinent properties to the Sprite handle
    addprop(bigFish,'accel');
    bigFish.accel = [0 0];
%     addprop(s,'i_correct');
%     addprop(s,'begTime');
%     
    
    % 3 CHOICES FISHES
    tFish = SpriteKit.Sprite('tFish');
    tFish.initState('on','img/half_fishyTorquoise.png',true);
    clickArea = size(imread('img/half_fishyTorquoise.png'));
    width = clickArea(1)/2;
    heigth = clickArea(2)/2;
    addprop(tFish,'clickL');
    addprop(tFish,'clickR');
    addprop(tFish,'clickU');
    addprop(tFish,'clickD');
    tFish.Location = [100 100];
    tFish.clickL = round(tFish.Location(1) - width);
    tFish.clickR = round(tFish.Location(1) + width);
    tFish.clickD = round(tFish.Location(2) - heigth);
    tFish.clickU = round(tFish.Location(2) + heigth);
    tFish.State = 'on';
    addprop(tFish, 'key');
    tFish.key = 1;
    %
    yFish = SpriteKit.Sprite('yFish');
    yFish.initState('on','img/half_FishyEllow.png',true);
    clickArea = size(imread('img/half_FishyEllow.png'));
    width = clickArea(1)/2;
    heigth = clickArea(2)/2;
    addprop(yFish,'clickL');
    addprop(yFish,'clickR');
    addprop(yFish,'clickU');
    addprop(yFish,'clickD');
    yFish.Location = [300 100];
    yFish.clickL = round(yFish.Location(1) - width);
    yFish.clickR = round(yFish.Location(1) + width);
    yFish.clickD = round(yFish.Location(2) - heigth);
    yFish.clickU = round(yFish.Location(2) + heigth);
    yFish.State = 'on';
    addprop(yFish, 'key');
    yFish.key = 2;
    %
    rFish = SpriteKit.Sprite('rFish');
    rFish.initState('on','img/half_FishyRed.png',true);
    clickArea = size(imread('img/half_FishyRed.png'));
    width = clickArea(1)/2;
    heigth = clickArea(2)/2;
    addprop(rFish,'clickL');
    addprop(rFish,'clickR'); 
    addprop(rFish,'clickU'); 
    addprop(rFish,'clickD');
    rFish.Location = [500 100];
    rFish.clickL = round(rFish.Location(1) - width);
    rFish.clickR = round(rFish.Location(1) + width);
    rFish.clickD = round(rFish.Location(2) - heigth);
    rFish.clickU = round(rFish.Location(2) + heigth);
    rFish.State = 'on';
    addprop(rFish, 'key');
    rFish.key = 3;
    


    
    %% Setup KeyPressFcn and others
%     G.onKeyPress = @keypressfcn;
%     G.onMouseRelease = @buttonupfcn;
        
    %% ------   start the GAME
%     iter = 0;
%     G.play(@()action(argin));
%     G.play(@action);


    
end % end of the setUpGame function 