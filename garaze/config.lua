Config                      = {}
Config.DrawDistance         = 15.0
Config.MarkerType           = 27
Config.MarkerSize           = {x = 4.5, y = 4.5, z = 1.0}
Config.MarkerColor          = {r = 230, g = 215, b = 260}
Config.MinimumHealth 		= 850.0
Config.ImpoundPrice			= 2500
Config.MaxSubs				= 2

Config.Locale = 'pl'


--system garaży, narazie poprawnie poprowadzony kod w kierunku stref, (in development)
Config.Marker = {
	Distance = 50,
	Garage = {
		Types = {
			36,
			35,
			33
		},
		Color = {r = 17, g = 255, b = 0},
		Sizes = {
			{x = 2.5, y = 2.5, z = 2.5},
			{x = 2.5, y = 2.5, z = 2.5},
			{x = 5.5, y = 5.5, z = 5.5}
		},
		Offsets = {
			0.65,
			1.1,
			2.2
		}
	},
	Spawn = {
		Type = 42,
		Color = { r = 102, g = 0, b = 102 },
		Size = {x = 1.5, y = 1.5, z = 1.5}
	},
	Other = {
		Type = 39,
		Color = {r = 50, g = 50, b = 204},
		Size = {x = 2.5, y = 2.5, z = 2.5}
	}
}

Config.Blip = {
	Garage = {
		Sprites = {
			417,
			418,
			515
		},
		Display = 4,
		Scales = {
			0.6,
			0.6,
			0.8
		},
		Color = 5,
		Names = {
			"Parking",
			"Przystań",
			"Lądowisko"
		},
		PrivateNames = {
			"Parking prywatny",
			"Przystań prywatna",
			"Lądowisko prywatne"
		}
	}
}

Config.Garages = {
	-- BLIP
	{
		Marker  = vector3(-926.21, -164.11, 40.98),
		DisplayBlip	= true,
		Visible = {},
		Zone	= 1
	},
	{
		Marker 	= vector3(-1173.18, -739.67, 19.04),
		DisplayBlip	= true,
		Visible = {},
		Zone	= 3
	},
	{
		Marker 	= vector3(385.51, -1657.58, 26.4),
		DisplayDisplayBlip	= true,
		Visible = {},
		Zone 	= 4
	},
	{
		Marker 	= vector3(235.01, -784.24, 29.74),
		DisplayDisplayBlip	= true,
		Visible = {},
		Zone 	= 1
	},
	{
		Marker 	= vector3(612.92, 95.05, 91.55),
		DisplayDisplayBlip	= true,
		Visible = {},
		Zone 	= 2
	},
	{
		Marker 	= vector3(1467.12, 3740.12, 32.68),
		DisplayBlip	= true,
		Visible = {},
		Zone 	= 2
	},
	{
		Marker 	= vector3(10.16, 6332.0, 30.34),
		DisplayBlip	= true,
		Visible = {},
		Zone 	= 2
	},
	{
		Marker 	= vector3(-1194.04, -1490.86, 3.48),
		DisplayBlip	= true,
		Visible = {},
		Zone 	= 1
	},
	{
		Marker 	= vector3(-3146.04, 1091.1, 19.79),
		DisplayBlip	= true,
		Visible = {},
		Zone 	= 3
	},
	{
		Marker 	= vector3(1688.43, 4774.03, 41.02),
		DisplayBlip	= true,
		Visible = {},
		Zone = 1
	},
	{
		Marker 	= vector3(572.16, 2724.44, 41.16),
		DisplayBlip = true,
		Visible = {},
		Zone 	= 2
	},
	{
		Marker  = vector3(30.98, -860.97, 29.67),
		DisplayBlip	= true,
		Visible = {},
		Zone	= 3
	},
	{
		Marker  = vector3(934.87, -1.06, 77.86),
		DisplayBlip	= true,
		Visible = {},
		Zone	= 2
	},
	{
		Marker  = vector3(405.05, -1278.6, 29.37),
		DisplayBlip	= true,
		Visible = {},
		Zone	= 1
	},
	{
		Marker  = vector3(-2020.7, -472.0, 10.48),
		DisplayBlip	= true,
		Visible = {},
		Zone	= 4
	},	
	{
		Marker  = vector3(-1879.58, -308.17, 48.34),
		DisplayBlip	= true,
		Visible = {},
		Zone	= 3
	},
	{
		Marker  = vector3(2769.66, 3467.82, 54.66),
		DisplayBlip	= true,
		Visible = {},
		Zone	= 2
	},
	{
		Marker  = vector3(333.21, -2038.74, 20.15),
		DisplayBlip	= true,
		Visible = {},
		Zone	= 1
	},
	{
		Marker  = vector3(1144.02, -3244.63, 5.0),
		DisplayBlip	= true,
		Visible = {},
		Zone	= 4
	},
	{
		Marker  = vector3(1004.04, -2336.67, 29.61),
		DisplayBlip	= true,
		Visible = {},
		Zone	= 3
	},
	{
		Marker  = vector3(-334.79, -751.01, 33.07),
		DisplayBlip	= true,
		Visible = {},
		Zone	= 1
	},
	{
		Marker  = vector3(-1635.5, -891.93, 8.05),
		DisplayBlip	= true,
		Visible = {},
		Zone	= 3
	},
	{
		Marker  = vector3(-1392.48, 80.49, 52.95),
		DisplayBlip	= true,
		Visible = {},
		Zone	= 2
	},
	{
		Marker  = vector3(-583.91, 315.77, 84.0),
		DisplayBlip	= true,
		Visible = {},
		Zone	= 1
	},
	{
		Marker  = vector3(-498.54, 57.09, 55.6),
		DisplayBlip	= true,
		Visible = {},
		Zone 	= 1
	},
	{
		Marker  = vector3(-92.24, 80.85, 70.7),
		DisplayBlip	= true,
		Visible = {},
		Zone	= 2
	},
	{
		Marker  = vector3(-801.08, -1305.94, 4.1),
		DisplayBlip	= true,
		Visible = {},
		Zone 	= 3
	},
	{
		Marker  = vector3(235.14, -3047.07, 5.04),
		DisplayBlip	= true,
		Visible = {},
		Zone	= 1
	},	
	{
		Marker  = vector3(-2973.64, 70.09, 10.71),
		DisplayBlip	= true,
		Visible = {},
		Zone	= 4
	},
	{
		Marker  = vector3(2587.52, 419.76, 107.56),
		DisplayBlip	= true,
		Visible = {},
		Zone 	= 1
	},
	{
		Marker  = vector3(273.85, -331.33, 44.02),
		DisplayBlip	= true,
		Visible = {},
		Zone 	= 2
	},
	{
		Marker  = vector3(-435.58, -351.24, 22.81),
		DisplayBlip	= true,
		Visible = {},
		Zone 	= 1
	},	

	{
		Marker 	= vector3(-818.73, -1201.28, 5.94),
		Visible = {},
		DisplayBlip = true,
		Zone = 1
	},	

	--cayo
	{
		Marker = vector3(4438.38, -4483.3, 3.3784),
		Visible = {},
		DisplayBlip = true,
		Zone = 2,
		--IsCayo = true,
	},	
	-- NO DisplayBlip
	{
		Marker 	= vector3(-795.99, 319.41, 84.78),
		DisplayBlip	= false,
		Visible = {}
	},
	{
		Marker  = vector3(-1039.03, -2714.28, 12.9),
		DisplayBlip	= false,
		Visible = {}
	},
	{
		Marker  = vector3(-35.35, -616.47, 34.18),
		DisplayBlip	= false,
		Visible = {}
	},
	{
		Marker  = vector3(-1039.03, -2714.28, 12.9),
		DisplayBlip	= false,
		Visible = {}
	},
	{
		Marker  = vector3(-1467.69, -504.56, 31.91),
		DisplayBlip	= false,
		Visible = {}
	},
	{
		Marker  = vector3(-626.1, 56.4, 42.83),
		DisplayBlip	= false,
		Visible = {}
	},
	{
		Marker  = vector3(-893.9, -344.26, 33.63),
		DisplayBlip	= false,
		Visible = {}
	},
	{
		Marker  = vector3(-1039.03, -2714.28, 12.9),
		DisplayBlip	= false,
		Visible = {}
	},
	{
		Marker  = vector3(1855.43, 2590.98, 44.77),
		DisplayBlip	= false,
		Visible = {}
	},
	{
		Marker 	= vector3(327.66, -205.42, 53.19),
		DisplayBlip	= false,
		Visible = {}
	},
	{
		Marker 	= vector3(320.75, -547.24, 27.84),
		DisplayBlip	= false,
		Visible = {}
	},
	{
		Marker  = vector3(219.75, -778.22, 29.9),
		DisplayBlip	= false,
		Visible = {}
	},
	{
		Marker  = vector3(-832.17, -394.01, 30.42),
		DisplayBlip	= false,
		Visible = {}
	},
	-- JOBS
	{
		Marker  = vector3(912.27, -952.84, 38.6),
		DisplayBlip	= false,
		Visible = {'mecano', 'offmecano'}
	},
	{
		Marker  = vector3(1867.46, 3683.23, 32.79),
		DisplayBlip	= false,
		Visible = {'police', 'offpolice', 'ambulance', 'offambulance'}
	},
	{
		Marker  = vector3(-271.02, 6334.22, 31.53),
		DisplayBlip	= false,
		Visible = {'ambulance', 'offambulance'}
	},
	{
		Marker  = vector3(-465.15, 6033.63, 30.44),
		DisplayBlip	= false,
		Visible = {'police', 'offpolice'}
	},
	{
		Marker  = vector3(1396.88, 1117.14, 113.94),
		DisplayBlip	= false,
		Visible = {'mafia'}
	},
	{
		Marker  = vector3(452.3, -996.99, 24.86),
		DisplayBlip	= false,
		Visible = {'police', 'offpolice'}
	},
	{
		Marker  = vector3(447.39, -997.01, 24.87),
		DisplayBlip	= false,
		Visible = {'police', 'offpolice'}
	},
}

Config.Impound = {
	vector3(481.59, -1316.86, 28.21),
	vector3(-191.06, -1162.61, 22.68)
}

Config.PoliceImpound = {
	vector3(485.35, -1096.99, 28.3),
	vector3(472.18, -1079.28, 28.3)
}

Config.SetSubowner = {
	vector3(-571.73, -212.6, 41.79)
}