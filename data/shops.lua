return {
	General = {
		name = 'Shop',
		blip = {
			id = 59, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'burger', price = 10 },
			{ name = 'water', price = 10 },
			{ name = 'cola', price = 10 },
		}, locations = {
			vec3(25.7, -1347.3, 29.49),
			vec3(-3038.71, 585.9, 7.9),
			vec3(-3241.47, 1001.14, 12.83),
			vec3(1728.66, 6414.16, 35.03),
			vec3(1697.99, 4924.4, 42.06),
			vec3(1961.48, 3739.96, 32.34),
			vec3(547.79, 2671.79, 42.15),
			vec3(2679.25, 3280.12, 55.24),
			vec3(2557.94, 382.05, 108.62),
			vec3(373.55, 325.56, 103.56),
		}, targets = {
			{
				ped = `mp_m_shopkeep_01`,
				scenario = 'WORLD_HUMAN_STAND_MOBILE',
				loc = vec3(24.47, -1346.62, 28.5),
				heading = 271.66,
				distance = 2.5,
			},
			{
				ped = `mp_m_shopkeep_01`,
				scenario = 'WORLD_HUMAN_STAND_MOBILE',
				loc = vec3(-3039.54, 584.38, 6.91),
				heading = 17.27,
				distance = 2.5,
			},
			{
				ped = `mp_m_shopkeep_01`,
				scenario = 'WORLD_HUMAN_STAND_MOBILE',
				loc = vec3(-3242.97, 1000.01, 11.83),
				heading = 357.57,
				distance = 2.5,
			},
			{
				ped = `mp_m_shopkeep_01`,
				scenario = 'WORLD_HUMAN_STAND_MOBILE',
				loc = vec3(1728.07, 6415.63, 34.04),
				heading = 242.95,
				distance = 2.5,
			},
			{
				ped = `mp_m_shopkeep_01`,
				scenario = 'WORLD_HUMAN_STAND_MOBILE',
				loc = vec3(1697.87, 4922.96, 41.06),
				heading = 324.71,
				distance = 2.5,
			},
			{
				ped = `mp_m_shopkeep_01`,
				scenario = 'WORLD_HUMAN_STAND_MOBILE',
				loc = vec3(1959.82, 3740.48, 31.34),
				heading = 301.57,
				distance = 2.5,
			},
			{
				ped = `mp_m_shopkeep_01`,
				scenario = 'WORLD_HUMAN_STAND_MOBILE',
				loc = vec3(549.13, 2670.85, 41.16),
				heading = 99.39,
				distance = 2.5,
			},
			{
				ped = `mp_m_shopkeep_01`,
				scenario = 'WORLD_HUMAN_STAND_MOBILE',
				loc = vec3(2677.47, 3279.76, 54.24),
				heading = 335.08,
				distance = 2.5,
			},
			{
				ped = `mp_m_shopkeep_01`,
				scenario = 'WORLD_HUMAN_STAND_MOBILE',
				loc = vec3(2556.66, 380.84, 107.62),
				heading = 356.67,
				distance = 2.5,
			},
			{
				ped = `mp_m_shopkeep_01`,
				scenario = 'WORLD_HUMAN_STAND_MOBILE',
				loc = vec3(372.66, 326.98, 102.57),
				heading = 253.73,
				distance = 2.5,
			},
		}
	}, 

	YouTool = {
		name = 'YouTool',
		blip = {
			id = 402, colour = 69, scale = 0.8 
		}, inventory = {
			{ name = 'lockpick', price = 10 }
		}, locations = {
			vec3(45.9936, -1749.1992, 29.6319),
			vec3(2747.2964, 3472.8250, 55.6705)
		}, targets = {
			{
				ped = `mp_m_waremech_01`,
				scenario = 'WORLD_HUMAN_CLIPBOARD',
				loc = vec3(343.0862, -1297.7999, 31.5096),
				heading = 164.5540,
				distance = 2.5,
			},
			{
				ped = `mp_m_waremech_01`,
				scenario = 'WORLD_HUMAN_CLIPBOARD',
				loc = vec3(2747.71, 3472.85, 54.67),
				heading = 255.08,
				distance = 2.5,
			},
		}
	},

	Apoteka = {
		name = 'Apoteka',
		blip = {
			id = 51, colour = 6, scale = 0.8 
		}, inventory = {
			{ name = 'lockpick', price = 10 }
		}, locations = {
			vec3(45.9936, -1749.1992, 29.6319)
		}, targets = {
			{
				ped = `a_f_m_bevhills_02`,
				scenario = 'WORLD_HUMAN_CLIPBOARD',
				loc = vec3(325.7456, -1074.4723, 28.4734),
				heading = 355.7596,
				distance = 2.5,
			},
		}
	},

	Ammunation = {
		name = 'Ammunation',
		blip = {
			id = 110, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'ammo-9', price = 15, },
			{ name = 'WEAPON_KNIFE', price = 1000 },
			{ name = 'WEAPON_BAT', price = 700 },
			{ name = 'WEAPON_PISTOL', price = 35000, metadata = { registered = true }, license = 'weapon' }
		}, locations = {
			vec3(-662.180, -934.961, 21.829),
			vec3(810.25, -2157.60, 29.62),
			vec3(1693.44, 3760.16, 34.71),
			vec3(-330.24, 6083.88, 31.45),
			vec3(252.63, -50.00, 69.94),
			vec3(22.56, -1109.89, 29.80),
			vec3(2567.69, 294.38, 108.73),
			vec3(-1117.58, 2698.61, 18.55),
			vec3(842.44, -1033.42, 28.19)
		}, targets = {
			{
				ped = `s_m_y_ammucity_01`,
				scenario = 'WORLD_HUMAN_COP_IDLES',
				loc = vec3(-661.96, -933.53, 20.83),
				heading = 177.05,
				distance = 2.5,
			},
			{
				ped = `s_m_y_ammucity_01`,
				scenario = 'WORLD_HUMAN_COP_IDLES',
				loc = vec3(809.68, -2159.13, 28.62),
				heading = 1.43,
				distance = 2.5,
			},
			{
				ped = `s_m_y_ammucity_01`,
				scenario = 'WORLD_HUMAN_COP_IDLES',
				loc = vec3(1692.67, 3761.38, 33.71),
				heading = 227.65,
				distance = 2.5,
			},
			{
				ped = `s_m_y_ammucity_01`,
				scenario = 'WORLD_HUMAN_COP_IDLES',
				loc = vec3(-331.23, 6085.37, 30.45),
				heading = 228.02,
				distance = 2.5,
			},
			{
				ped = `s_m_y_ammucity_01`,
				scenario = 'WORLD_HUMAN_COP_IDLES',
				loc = vec3(253.63, -51.02, 68.94),
				heading = 72.91,
				distance = 2.5,
			},
			{
				ped = `s_m_y_ammucity_01`,
				scenario = 'WORLD_HUMAN_COP_IDLES',
				loc = vec3(23.0, -1105.67, 28.80),
				heading = 162.91,
				distance = 2.5,
			},
			{
				ped = `s_m_y_ammucity_01`,
				scenario = 'WORLD_HUMAN_COP_IDLES',
				loc = vec3(2567.48, 292.59, 107.73),
				heading = 349.68,
				distance = 2.5,
			},
			{
				ped = `s_m_y_ammucity_01`,
				scenario = 'WORLD_HUMAN_COP_IDLES',
				loc = vec3(-1118.59, 2700.05, 17.55),
				heading = 221.89,
				distance = 2.5,
			},
			{
				ped = `s_m_y_ammucity_01`,
				scenario = 'WORLD_HUMAN_COP_IDLES',
				loc = vec3(841.92, -1035.32, 27.19),
				heading = 1.56,
				distance = 2.5,
			},
		}
	},

	Medicine = {
		name = 'Medicine Cabinet',
        inventory = {
			{ name = 'medikit', price = 26 },
			{ name = 'bandage', price = 5 }
		}, locations = {
			vec3(-929.4109, -756.2195, 16.4906)
		}, targets = {
			{
				ped = `s_m_m_doctor_01`,
				scenario = 'WORLD_HUMAN_CLIPBOARD',
				loc = vec3(-929.4109, -756.2195, 15.4906),
				heading = 221.9584,
				distance = 2.5,
			},
		}
	},

	VendingMachineDrinks = {
		name = 'Vending Machine',
		inventory = {
			{ name = 'water', price = 40 },
			{ name = 'cola', price = 50 },
		},
		model = {
			`prop_vend_soda_02`, `prop_vend_fridge01`, `prop_vend_water_01`, `prop_vend_soda_01`
		}
	}
}
