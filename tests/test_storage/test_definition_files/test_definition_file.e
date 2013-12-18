note
	description: "Summary description for {TEST_DEFINITION_FILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_DEFINITION_FILE

inherit

	EQA_TEST_SET

feature -- Test routines

	test_retrieve_place_from_def
		note
			testing: "covers/{DEFINITION_FILE}.retrieve_from_def"
		local
			registry: DEFINITION_FILE_REGISTRY
			definition_file: DEFINITION_FILE
			description_item: PLACE_DESCRIPTION_ITEM
			exit: PLACE_EXIT
		do
			definition_file := registry.get_definition_file_for("PLACE")
			definition_file.create_object_from_def ("poblado-calle01")
			if not definition_file.error_occurred then
    			if attached {PLACE} definition_file.created_object as created_place then
    			    assert ("correctly retrieved", equal (created_place.slug.to_string, "poblado-calle01"))
    			    assert ("correct author", equal (created_place.author.to_string, "Mandos"))
    			    assert ("correct area_name", equal (created_place.area_name.to_string, "poblado"))
    			    assert ("correct place_name", equal (created_place.place_name.to_string, "Final de la Calle del Sur"))
    			    assert ("correct aura", created_place.aura.to_integer = 50)
    			    assert ("correct place_type", equal (created_place.place_type.to_string, "Poblacion"))
    			    assert ("correct place_subtype", equal (created_place.place_subtype.to_string, "calle"))
    			    assert ("correct capacity", created_place.capacity.to_real = 40.0)
    			    assert ("correct light", created_place.light.to_integer = 60)
    			    assert ("correct hiding_value", created_place.hiding_value.to_integer = 10)
    			    assert ("correct description count", created_place.description.count = 3)
    			    from
    			        created_place.description.start
    			    until
    			        created_place.description.after
    			    loop
    			        description_item := created_place.description.item_for_iteration
    			        assert ("correct description_item difficulty", description_item.difficulty_level.to_integer = 0)
    			        created_place.description.forth
    			    end
    			    assert ("correct exits count", created_place.exits.count = 4)
    			    from
    			        created_place.exits.start
    			    until
    			        created_place.exits.after
    			    loop
    			        exit := created_place.exits.item_for_iteration
    			        assert ("correct exit difficulty", exit.difficulty_level.to_integer = 0)
    			        created_place.exits.forth
    			    end
    			else
    			    assert ("object retrieved is not a place", False)
    			end
    		else
				assert ("retrieve error, message: " + definition_file.last_error_message, False)
			end
		end

	test_retrieve_unexistent_slug
		note
			testing: "covers/{DEFINITION_FILE}.retrieve_from_def"
		local
			registry: DEFINITION_FILE_REGISTRY
			definition_file: DEFINITION_FILE
		do
			definition_file := registry.get_definition_file_for("PLACE")
			definition_file.create_object_from_def ("dummy_area-dummy_place")
			if not definition_file.error_occurred then
				assert ("This should not occur, the slug does not exist", False)
			end
		end

end
