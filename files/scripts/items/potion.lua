dofile_once( 'mods/empty_the_blackhole_catgirl/files/scripts/empty/empty_utility.lua' )

-- NOTE( Petri ):
-- There is a mods/nightmare potion.lua which overwrites this one.

materials_standard =
{
	{
		material='lava',
		cost=300,
	},
	{
		material='water',
		cost=200,
	},
	{
		material='blood',
		cost=200,
	},
	{
		material='alcohol',
		cost=200,
	},
	{
		material='oil',
		cost=200,
	},
	{
		material='slime',
		cost=200,
	},
	{
		material='acid',
		cost=400,
	},
	{
		material='radioactive_liquid',
		cost=300,
	},
	{
		material='gunpowder_unstable',
		cost=400,
	},
	{
		material='liquid_fire',
		cost=400,
	},
	{
		material='blood_cold',
		cost=300,
	},
}

materials_magic =
{
	{
		material='magic_liquid_unstable_teleportation',
		cost=500,
	},
	{
		material='magic_liquid_polymorph',
		cost=500,
	},
	{
		material='magic_liquid_random_polymorph',
		cost=500,
	},
	{
		material='magic_liquid_berserk',
		cost=500,
	},
	{
		material='magic_liquid_charm',
		cost=800,
	},
	{
		material='magic_liquid_invisibility',
		cost=700,
	},
	{
		material='material_confusion',
		cost=600,
	},
	{
		material='magic_liquid_movement_faster',
		cost=500,
	},
	{
		material='magic_liquid_faster_levitation',
		cost=500,
	},
	{
		material='magic_liquid_worm_attractor',
		cost=600,
	},
	{
		material='magic_liquid_protection_all',
		cost=800,
	},
	{
		material='magic_liquid_mana_regeneration',
		cost=500,
	},
}

if ( get_setting_by_def( 'EFFECT_CHANGE_POTION_CONTENT' ) ) then
	add_table( materials_standard, {
		{
			material='blood_worm',
			cost=600,
		},
		{
			material='poison',
			cost=400,
		},
		{
			material='plastic_molten',
			cost=300,
		},
		{
			material='glass_molten',
			cost=300,
		},
	} )

	add_table( materials_magic, {
		{
			material='gold_molten',
			cost=600,
		},
		{
			material='magic_liquid_teleportation',
			cost=700,
		},
		{
			material='midas_precursor',
			cost=800,
		},
		{
			material='void_liquid',
			cost=700,
		},
		{
			material='material_darkness',
			cost=600,
		},
		{
			material='mimic_liquid',
			cost=800,
		},
		{
			material='porridge',
			cost=800,
		},
		{
			material='just_death',
			cost=500,
		},
		{
			material='magic_liquid_weakness',
			cost=700,
		},
		{
			material='magic_liquid_hp_regeneration_unstable',
			cost=700,
		},
		{
			material='magic_liquid_hp_regeneration',
			cost=800,
		},
	} )
end

function init( potion )
	local mat = get_comp_value( potion, 'VariableStorageComponent', nil, {
		{ 'value_string', '' },
	}, 'potion_material' )

	if ( not mat or mat == '' ) then
		set_r_seed( potion )

		if ( Random( 1, 100 ) <= 60 ) then
			if ( Random( 1, 100 ) <= 3 ) then
				mat = 'purifying_powder'
			else
				mat = get_random_from( materials_magic ).material
			end
		else
			mat = get_random_from( materials_standard ).material
		end

		if ( Random( 1, 100 ) <= 3 ) then
			local rnd = Random( 1, 7 )
			if ( rnd <= 2 ) then
				mat = 'sima'
			elseif ( rnd <= 4 ) then
				mat = 'juhannussima'
			elseif ( rnd <= 6 ) then
				mat = 'beer'
			else
				mat = 'mammi'
			end
		end
	end

	local total_cap = 1000

	if ( get_setting_by_def( 'EFFECT_CHANGE_POTION_VOLUME' ) ) then
		set_comp_value( potion, 'MaterialSuckerComponent', nil, {
			{ 'barrel_size', 2000 },
		}, nil, nil )

		total_cap = 2000
	end

	AddMaterialInventoryMaterial( potion, mat, total_cap )
end
