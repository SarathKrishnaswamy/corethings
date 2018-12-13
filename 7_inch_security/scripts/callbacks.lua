  
json = require "json"

local type, pairs, ipairs, assert
  = type, pairs, ipairs, assert
 
--- @param gre#context mapargs
function load_home_screen(mapargs)
  data_table={}
  data_table['command'] = 'load_home_screen'
  data_table['time'] = os.date()
  json_string = json.encode(data_table)
  send_event(json_string)
end




------------------ Lua Utility functions ------------------------
function show_hide_controls(is_hide, controls_array)
  data_table ={}
  data_table["hidden"] = is_hide
  if (controls_array ~= nil) then
    print('hiding the controls')
    print_table(controls_array)
    count = table.getn(controls_array)
    for i=1, count do
      print("hide the control--->"..controls_array[i] ) 
      gre.set_control_attrs(controls_array[i], data_table)  
    end
  end    
end




------------------------- All button callbacks for "Entry points" screen--------------------------

function entrypoints_button_pressed(mapargs)
  print('entrypoints_button_pressed')
   doors_button_pressed(mapargs)
end

function doors_button_pressed(mapargs)
   print('doors_button_pressed')
  
   -- show all the buttons
   show_hide_controls(0, {"grid_layer.tile1_more_button","grid_layer.tile2_more_button","grid_layer.tile3_more_button"})
    -- show all the tiles
   show_hide_controls(0, {"grid_layer.tile1_info","grid_layer.tile2_info","grid_layer.tile3_info"})
   
   -- Load all the entry point details from the server for the type dlock
   load_all_entrypoints("dlock")
end

function window_button_pressed(mapargs)
   print('window_button_pressed')
   
   -- show all the buttons
   show_hide_controls(0, {"grid_layer.tile1_more_button","grid_layer.tile2_more_button","grid_layer.tile3_more_button"})
   -- show all the tiles
   show_hide_controls(0, {"grid_layer.tile1_info","grid_layer.tile2_info","grid_layer.tile3_info"})   
   
   -- Load all the entry point details from the server for the type wm
   load_all_entrypoints("wm")
end

function others_button_pressed(mapargs)
   print('others_button_pressed')
   
   -- show all the buttons
   show_hide_controls(0, {"grid_layer.tile1_more_button","grid_layer.tile2_more_button","grid_layer.tile3_more_button"})
   -- show all the tiles
   show_hide_controls(0, {"grid_layer.tile1_info","grid_layer.tile2_info","grid_layer.tile3_info"})   
   
   -- Load all the entry point details from the server for the type wm
   load_all_entrypoints("others")
end

function more_button1_pressed(mapargs) 
   print('more_button1_pressed')
   id = gre.get_data("grid_layer.tile1_info.id")
   load_entry_point(id["grid_layer.tile1_info.id"])
end

function more_button2_pressed(mapargs) 
   print('more_button2_pressed')
   id = gre.get_data("grid_layer.tile2_info.id")
   load_entry_point(id["grid_layer.tile2_info.id"])
end

function more_button3_pressed(mapargs) 
   print('more_button3_pressed')
   id = gre.get_data("grid_layer.tile3_info.id")
   load_entry_point(id["grid_layer.tile3_info.id"])
end


------------------------- All callbacks for "The Entry point" screen--------------------------

function lock_the_entrypoint_device(mapargs)
  id = gre.get_data("entrypoint.id")
  action_lock_device(id["entrypoint.id"], "locked")
end

function unlock_the_entrypoint_device(mapargs)
  id = gre.get_data("entrypoint.id")
  action_lock_device(id["entrypoint.id"], "unlocked")
end

function should_monitor_toggle(mapargs)
  id = gre.get_data("entrypoint.id")
  key = gre.get_data("entrypoint.intrusion_toggle.key")
  prev_value = gre.get_data("entrypoint.intrusion_toggle.on_off")
  
  --- Convert the on/off to True/false . Also toggle the values
  value = false
  if(prev_value["entrypoint.intrusion_toggle.on_off"] == "off") then
    value = true
  end
  
  update_device_settings(id["entrypoint.id"], key["entrypoint.intrusion_toggle.key"], value)
end

function tamper_reaction_toggle(mapargs)
  id = gre.get_data("entrypoint.id")
  key = gre.get_data("entrypoint.tamper_toggle.key")
  prev_value = gre.get_data("entrypoint.tamper_toggle.on_off")
  
  --- Convert the on/off to True/false . Also toggle the values
  value = false
  if(prev_value ["entrypoint.tamper_toggle.on_off"]== "off") then
    value = true
  end
  
  update_device_settings(id["entrypoint.id"], key["entrypoint.tamper_toggle.key"], value)
end
--------------- API to get the data from server ---------
function update_device_settings(deviceid, key, value)
  data_table={}
  data_table['command'] = 'action_lock_device'
  data_table["id"] = device_id;
  data_table["key"] = key;
  data_table["value"] = value;
  json_string = json.encode(data_table)
  print('Send update_device_settings command to server')
  send_event(json_string)
end

function action_lock_device(id, status)
  data_table={}
  data_table['command'] = 'action_lock_device'
  data_table["id"] = id;
  data_table["status"] = status;
  json_string = json.encode(data_table)
  print('Send action_lock_device command to server')
  send_event(json_string)
end

function load_all_entrypoints(type)
  data_table={}
  data_table['command'] = 'ip7_get_all_entry_points'
  data_table['device_type'] = type;
  print_table(data_table)
  json_string = json.encode(data_table)
  print('Send load_all_entrypoints command to server')
  send_event(json_string)
 end
 
function load_entry_point(entry_point_id)
  data_table={}
  data_table['command'] = 'ip7_get_entry_point_info'
  data_table["id"] = entry_point_id;
  json_string = json.encode(data_table)
  print('Send load_entry_point command to server')
  
  send_event(json_string)
end


