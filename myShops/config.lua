Config = {}
Translation = {}

Config.Locale = 'en'

Config.NotificationPicture = 'CHAR_MANUEL'

Config.EnableBuyOption = false -- Should players be able to sell items at the shop
Config.PriceBuyDivide = 2 -- Sell price / this value = buy price
Config.useWeightSystem = false

Config.Shops = {

    {type = "shopspozywczy", name = "Sklep Spożywczy", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =372.48, y =326.74, z =103.57, rot = 240.0}, -- ROT, to nic innego jak heading
    {type = "shopspozywczy", name = "Sklep Spożywczy", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x = 2556.94, y = 380.71, z = 108.62, rot = 342.38},
    {type = "shopspozywczy", name = "Sklep Spożywczy", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =-3039.04, y =584.18, z =7.91, rot = 357.0},
    {type = "shopspozywczy", name = "Sklep Spożywczy", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =-3242.54, y = 999.74, z =12.830, rot = 336.15},
    {type = "shopspozywczy", name = "Sklep Spożywczy", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =549.25, y =2671.34, z =42.156, rot = 82.59},
    {type = "shopspozywczy", name = "Sklep Spożywczy", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =1959.97, y =3739.96, z =32.34, rot = 288.98},
    {type = "shopspozywczy", name = "Sklep Spożywczy", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_lowendsalon", blip = 52, color = 2, x =2677.51, y =3279.49, z =55.241, rot = 303.4},
    {type = "shopspozywczy", name = "Sklep Spożywczy", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =-1222.16, y =-908.53, z =12.33, rot = 23.5},	
    {type = "shopspozywczy", name = "Sklep Spożywczy", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =-2966.28, y =390.67, z =15.043, rot = 85.91},
    {type = "shopspozywczy", name = "Sklep Spożywczy", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =1166.14, y =2710.830, z =38.157, rot = 168.31},
    {type = "shopspozywczy", name = "Sklep Spożywczy", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =1392.69, y =3606.548, z =34.980, rot = 186.81},
    {type = "shopspozywczy", name = "Sklep Spożywczy", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =-47.08, y =-1758.46, z =29.421, rot = 53.42},
    {type = "shopspozywczy", name = "Sklep Spożywczy", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =1164.883, y =-323.38, z =69.21, rot = 106.81},
    {type = "shopspozywczy", name = "Sklep Spożywczy", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =-705.9601, y =-914.250, z = 19.215, rot = 110.24},
    {type = "shopspozywczy", name = "Sklep Spożywczy", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =-1819.8, y =793.92, z =138.09, rot = 154.0},
    {type = "shopspozywczy", name = "Sklep Spożywczy", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =196.85, y =-34.01, z =69.89, rot = 336.65},	
    {type = "shopspozywczy", name = "Sklep Spożywczy", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =1697.65, y =4923.14, z = 42.063, rot = 352.85},
	--cayo
	{type = "shopspozywczy", name = "Sklep Spożywczy", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =4467.0, y =-4463.42, z = 4.37, rot = 199.39},
	--
    {type = "shopalkoholowy", name = "Sklep Alkoholowy", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_lowendsalon", blip = 52, color = 64, x =1727.91, y =6415.52, z =35.04, rot = 214.3},
    {type = "shopalkoholowy", name = "Sklep Alkoholowy", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_lowendaslon", blip = 52, color = 64, x =1134.12, y =-982.77, z =46.42, rot = 279.46},
    {type = "shopalkoholowy", name = "Sklep Alkoholowy", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_lowendalson", blip = 52, color = 64, x =-1486.21, y =-377.92, z =40.163, rot = 126.46},	
	{type = "bar", name= "Tequil-La La", pedmodel = "s_m_y_barman_01", banner = "shopui_title_highendsalon", blip = false, color = 27, x=-561.906, y=286.44, z=82.18, rot = 263.6},
	{type = "bar", name= "Yellow Jack", pedmodel = "mp_f_chbar_01", banner = "shopui_title_highendsalon", blip= false, color = 27, x=1984.12, y=3054.58, z=47.22, rot = 251.7},
	{type = "fastfood", name= "Lucky Plucker", pedmodel = "u_m_y_burgerdrug_01", banner = "shopui_title_conveniencestore", blip= 267, color = 17, x=130.31, y=-1479.03, z=29.14, rot = 142.69},
	{type = "shopspozywczy", name = "Sklep Spożywczy", pedmodel = "mp_m_shopkeep_01", banner = "shopui_title_conveniencestore", blip = 52, color = 2, x =24.5, y =-1347.33, z = 29.5, rot = 270.01},
	{type = "shopbotanik", name = "Sklep botaniczny", pedmodel = "s_m_y_construct_01", banner = "shopui_title_conveniencestore", blip = false, color = 2, x =1615.11, y =-2264.02, z = 106.44, rot = 80.02},	
	{type = "techniczny", name = "Sklep Techniczny", pedmodel = "s_m_y_airworker", banner = "shopui_title_conveniencestore", blip = 478, color = 10, x =46.83, y =-1749.61, z = 29.63, rot = 49.43},		
	{type = "hotdogschi", name = "FastFood", pedmodel = "u_m_y_burgerdrug_01", banner = "shopui_title_conveniencestore", blip = false, color = 10, x =44.36, y =-1005.66, z = 29.29, rot = 336.82},			
	{type = "pearlsmolo", name = "Pearls Restaurant", pedmodel = "a_m_y_business_02", banner = "shopui_title_conveniencestore", blip = false, color = 2, x =-1818.18, y =-1199.29, z = 14.48, rot = 28.47},		
	{type = "jachtbarman", name = "Barman", pedmodel = "s_f_y_bartender_01", banner = "shopui_title_conveniencestore", blip = false, color = 2, x =-2336.55, y =-661.75, z = 13.42, rot = 317.9},	
	{type = "jachtbarman", name = "Barman", pedmodel = "a_m_y_beach_01", banner = "shopui_title_conveniencestore", blip = false, color = 2, x =-2245.23, y =-621.86, z = 14.81, rot = 348.48},	{type = "fastfood", name = "Up-n-Atom Burger", pedmodel = "csb_burgerdrug", banner = "shopui_title_conveniencestore", blip = 103 , color = 49, x =90.85, y =285.67, z = 110.23, rot = 161.77},
	{type = "fastfood", name = "Luckplucker2", pedmodel = "a_m_y_hipster_03", banner = "shopui_title_conveniencestore", blip = false, color = 2, x =139.56, y =-1468.88, z = 29.36, rot = 53.22},
    {type = "jachtbarman", name = "Sklep Alkoholowy", pedmodel = "a_m_y_beach_01", banner = "shopui_title_lowendsalon", blip = false, color = 64, x =1222.16, y =-419.61, z =67.78, rot = 341.41},	
	{type = "kawiarnia", name = "Bean Coffe", pedmodel = "s_f_y_clubbar_01", banner = "shopui_title_conveniencestore", blip = false, color = 64, x =-635.71, y =234.83, z =81.88, rot = 268.57},
	{type = "narzedzia", name = "You Tool", pedmodel = "s_m_y_airworker", banner = "shopui_title_lowendsalon", blip = 569, color = 2, x =2747.52, y =3472.79, z =55.67, rot = 247.55},	
	--nielegalne
	{type = "blackshop", name = "U Marusia", pedmodel = "g_m_m_korboss_01", banner = "shopui_title_highendsalon", blip = false, color = 64, x =551.37, y =-2209.58, z =68.98, rot = 275.34},	
}

Config.ShopItems = {
    ['shopspozywczy'] = {
        {label = "Kanapka z serem", name = "sandwich", price = 5, max = 20},
        {label = "Czekolada", name = "chocolate", price = 7, max = 20},
        {label = "Donut", name = "donut", price = 6, max = 20},
        {label = "Woda", name = "water", price = 3, max = 20},
        {label = "E-Cola", name = "cola", price = 5, max = 20},
        {label = "Sprunk", name = "icetea", price = 6, max = 20},
        {label = "Energetyk", name = "redbull", price = 10, max = 20},
        {label = "Mleko", name = "milk", price = 5, max = 20},
        {label = "Papieros Redwood", name = "redwcig", price = 5, max = 20},
        {label = "Papieros Marlboro", name = "marlborocig", price = 7, max = 20},
        {label = "Zapalniczka", name = "lighter", price = 10, max = 10},
        {label = "Paczka Redwood", name = "redw", price = 30, max = 2},
        {label = "Paczka Marlboro", name = "marlboro", price = 35, max = 2},
    },
    ['shopbotanik'] = {
        {label = "Nasiono", name = "seed_weed", price = 15, max = 120},
    },	
    ['techniczny'] = {
        {label = "Wiertarka", name = "drill", price = 600, max = 2},
		{label = "Kajdanki", name = "handcuffs", price = 800, max = 1},
		{label = "Wytrych", name = "lockpick", price = 150, max = 5},
		{label = "Torba", name = "bag", price = 30, max = 5},
    },	
    ['hotdogschi'] = {
        {label = "HotDog", name = "hotdog", price = 15, max = 15},
        {label = "E-Cola", name = "cola", price = 7, max = 20},
    },
    ['pearlsmolo'] = {
        {label = "Woda", name = "water", price = 5, max = 20},
        {label = "Jabłko", name = "apple", price = 15, max = 15},
    },		
    ['shopalkoholowy'] = {
        {label = "Piwo", name = "beer", price = 20, max = 20},
        {label = "E-Cola", name = "cola", price = 10, max = 20},
        {label = "Papieros", name = "cigarette", price = 15, max = 20},
        {label = "Zapalniczka", name = "lighter", price = 10, max = 10},
        {label = "Wódka", name = "vodka", price = 35, max = 100},		
        {label = "Papieros Redwood", name = "redwcig", price = 10, max = 20},
        {label = "Papieros Marlboro", name = "marlborocig", price = 15, max = 20},
        {label = "Zapalniczka", name = "lighter", price = 20, max = 10},
        {label = "Paczka Redwood", name = "redw", price = 40, max = 2}, 
        {label = "Paczka Marlboro", name = "marlboro", price = 45, max = 2},
    },	
    ['bar'] = {
        {label = "Piwo", name = "beer", price = 30, max = 20},
        {label = "Wino", name = "wine", price = 200, max = 20},
        {label = "Wódka", name = "vodka", price = 50, max = 20},
        {label = "Whiskey", name = "whisky", price = 50, max = 20},
        {label = "Papieros Redwood", name = "redwcig", price = 15, max = 20},
        {label = "Zapalniczka", name = "lighter", price = 25, max = 10},
        {label = "Paczka Redwood", name = "redw", price = 45, max = 2}, 
        {label = "Kubańskie cygaro", name = "cubancigar", price = 55, max = 5}, 
    },
    ['jachtbarman'] = {
        {label = "Piwo", name = "beer", price = 30, max = 20},
        {label = "Wino", name = "wine", price = 200, max = 20},
        {label = "Wódka", name = "vodka", price = 50, max = 20},
        {label = "Whiskey", name = "whisky", price = 50, max = 20},
        {label = "Papieros Redwood", name = "redwcig", price = 15, max = 20},
        {label = "Zapalniczka", name = "lighter", price = 25, max = 10},
        {label = "Paczka Redwood", name = "redw", price = 45, max = 2}, 
    },
    ['fastfood'] = {
        {label = "Burger", name = "burger", price = 30, max = 5},
        {label = "Chrupki serowe", name = "cheesebows", price = 15, max = 15},
        {label = "Hot-Dog", name = "hotdog1", price = 25, max = 15},
        {label = "CocaCola", name = "cocacola", price = 15, max = 10},
        {label = "Babeczka", name = "cupcake", price = 20, max = 15},
        {label = "Sok wieloowocowy", name = "sok", price = 30, max = 10}
    },
    ['narzedzia'] = {
        {label = "Młot oraz przecinak", name = "hammerwirecutter", price = 50, max = 5},
        {label = "Łom", name = "crowbar", price = 15, max = 15},
        {label = "Wiertło", name = "drill", price = 200, max = 15},
        {label = "Dziwne urządzenie", name = "hackerDevice", price = 90, max = 10},
    },		
    ['kawiarnia'] = {
		{label = "coffe", name = "coffe", price = 15, max = 5},
    },		
    ['blackshop'] = {
		{label = "Tlumik", name = "silencieux", price = 5000, max = 5},
		{label = "Lampa do broni", name = "flashlightw", price = 2500, max = 5},
		{label = "Uchwyt", name = "grip", price = 2500, max = 5},
    },		
}


Translation = {
    ['en'] = {
        ['infobar_interact'] = 'Naciśnij ~g~E~s~, aby kupić przedmioty',
        ['buy'] = '~g~Kup',
        ['sell'] = '~r~Sprzedaj',
        ['how_much'] = 'Podaj ilość?',
        ['how_much_sell'] = 'Podaj ilość?',
        ['purchased'] = '~g~',
        ['purchased2'] = 'x ',
        ['purchased3'] = ' Kupiłeś za ',
        ['purchased4'] = '$~s~!',
        ['sold'] = '~o~',
        ['sold2'] = 'x ',
        ['sold3'] = ' Sprzedałeś za ',
        ['sold4'] = '$~s~!',
        ['shop'] = 'Sklep',
        ['purchased_title'] = 'Kupiłeś przedmiot/y!',
        ['sold_title'] = 'Sprzedałeś przedmiot/y!',
        ['can_not_carry'] = 'Nie możesz tyle unieść!',
        ['not_enough_money'] = 'Nie masz tyle pieniędzy!',
        ['not_enough_items'] = 'Nie masz tylu przedmiotów!',
    },
}