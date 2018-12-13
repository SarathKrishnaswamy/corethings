json = require "json"

function test_send(message)

  print('Message received:'..message)
  data_table = json.decode(message)
  
  print('command received :' .. data_table['command'])
  command = data_table['command']
  
  --handles load_home_screen
  if(command == "load_home_screen") then
     handle_message_with_json(get_lock_screen())
  
  --handles ip7_get_all_entry_points
  else if(command == "ip7_get_all_entry_points") then
     type = data_table["device_type"] 
     handle_message_with_json(ip7_get_all_entry_points(type))
 
  -- handles ip7_get_entry_point_info
  else if(command == "ip7_get_entry_point_info") then
    id = data_table["id"]
    handle_message_with_json(ip7_get_entry_point_info(id))
    
  -- handles update_device_settings
  else if(command == "update_device_settings") then
    id = data_table["id"]
    key = data_table["key"]
    value = data_table ["value"]
   update_device_settings(id, key, value)
   
   --handles action_lock_device
  else if(command == "action_lock_device") then
    id = data_table["id"]
    status = data_table["status"]
    action_lock_device(id, status)
   end
  end
  end
  end
  end
end


------------------------------lock Screen-----------------------------------------------
function get_lock_screen()
  time = os.date("*t")
  final_message = {}
  message ={}
  message["sidelayer.3_phone_notify_count.phone_notify_count"]=4
  message["sidelayer.3_notify_count.notify_count"]=2
  message["sidelayer.3_message_notify_count.message_notify_count"]=7
  message["center_layer.status_on3.image_fourwall_status"]="images/status_on.png"
  message["center_layer.status_on2.image_home_status"]="images/status-off.png"
  message["center_layer.status_on1.image_status"]="images/status_on.png"
  message["center_layer.status_on.image_status"]="images/status-off.png"
  message["center_layer.status_text.status_text"]="Gardern Camera Turned On"
  message["center_layer.time_text.time_text"] = ("%02d:%02d"):format(time.hour, time.min)
  final_message["hide_controls"] = {}
  final_message["data"] = message
  
  --json_string = json.encode(message)
  return final_message
end
------------------------------ip7_get_all_entry_points-----------------------------------------------

function ip7_get_all_entry_points(type)
  print("Inside ip7_get_all_entry_points method")
    message ={}
  --- Return all entry points information based on the type provided
  if(type == "dlock") then
     print("Inside dlock method")
  
    message["grid_layer.tile1_info.id"] = "entrypoint_id1"
    message["grid_layer.tile1_info.text"] = "Front Door"
    message["grid_layer.tile1_info.lock_unlock_text"]="Locked"
    message["grid_layer.tile1_info.lock_unlock_image"]="images/lock_icon.png"
    message["grid_layer.tile1_info.last_modified_text"]  ="Last Modified : 10:10 am"
    message["grid_layer.tile1_info.battery_image"]="images/battery_100%.png"
    
    message["grid_layer.tile2_info.id"] = "entrypoint_id2"
    message["grid_layer.tile2_info.text"] = "Garage Door"
    message["grid_layer.tile2_info.lock_unlock_text"]="Unlocked"
    message["grid_layer.tile2_info.lock_unlock_image"]="images/unlock.png"
    message["grid_layer.tile2_info.last_modified_text"]="Last Modified : 11:20 am"
    message["grid_layer.tile2_info.battery_image"]="images/battery_icon.png"
    
    message["grid_layer.tile3_info.id"] = "entrypoint_id3"
    message["grid_layer.tile3_info.text"] = "Back Door"
    message["grid_layer.tile3_info.lock_unlock_text"]="Locked"
    message["grid_layer.tile3_info.lock_unlock_image"]="images/lock_icon.png"
    message["grid_layer.tile3_info.last_modified_text"]="Last Modified : 9:20 am"
    message["grid_layer.tile3_info.battery_image"]="images/battery_100%.png"
    
    final_message['data'] = message
    final_message['hide_controls'] = {}
  end
  
  if(type == "wm") then
    print("Inside wm method")

    message["grid_layer.tile1_info.id"] = "entrypoint_id4"
    message["grid_layer.tile1_info.text"] = "Bedroom Window"
    message["grid_layer.tile1_info.lock_unlock_text"]="Locked"
    message["grid_layer.tile1_info.lock_unlock_image"]="images/lock_icon.png"
    message["grid_layer.tile1_info.last_modified_text"]  ="Last Modified : 10:10 am"
    message["grid_layer.tile1_info.battery_image"]="images/battery_100%.png"
    
    message["grid_layer.tile2_info.id"] = "entrypoint_id5"
    message["grid_layer.tile2_info.text"] = "Kitchen Window"
    message["grid_layer.tile2_info.lock_unlock_text"]="Unlocked"
    message["grid_layer.tile2_info.lock_unlock_image"]="images/unlock.png"
    message["grid_layer.tile2_info.last_modified_text"]="Last Modified : 11:20 am"
    message["grid_layer.tile2_info.battery_image"]="images/battery_icon.png"
   
    
    final_message['data'] = message
    final_message['hide_controls'] = {"grid_layer.tile3_info","tile3_more_button"}
  end
  
   if(type == "others") then
    print("Inside others")
    
    message["grid_layer.tile1_info.id"] = "entrypoint_id6"
    message["grid_layer.tile1_info.text"] = "Others"
    message["grid_layer.tile1_info.lock_unlock_text"]="Locked"
    message["grid_layer.tile1_info.lock_unlock_image"]="images/lock_icon.png"
    message["grid_layer.tile1_info.last_modified_text"]  ="Last Modified : 10:10 am"
    message["grid_layer.tile1_info.battery_image"]="images/battery_100%.png"
    
    final_message['data'] = message
    final_message['hide_controls'] = {"grid_layer.tile3_info","tile3_more_button","grid_layer.tile2_info","tile2_more_button"}
  end
  print('after if loop')
  print_table(final_message[data])
  print_table(final_message[hide_controls])
  --json_string = json.encode(message)
  --print(json_string)
  return final_message
end


------------------------------ip7_get_entry_point_info-----------------------------------------------


function ip7_get_entry_point_info(id)
  final_message = {}
  
  --- Return entry point information based on the entry point id
  if(id == "entrypoint_id1") then
    message = populate_entrypoint_values("entrypoint_id1", "Front Door","images/lock_icon.png","Locked","images/intrusion_toggle.png","on", 
            "images/toggle_off.png","off","images/access_person_1.png","images/access_person_2.png", "images/access_person_3.png","images/access_person_4.png")
    
    final_message['data'] = message
    final_message['hide_controls'] = {"entrypoint.lock_btn"}
  end

  if(id == "entrypoint_id2") then
    message = populate_entrypoint_values("entrypoint_id2", "Garage Door","images/unlock.png","Unlocked","images/intrusion_toggle.png","on", 
            "images/tamper_toggle.png","on","images/access_person_1.png","images/access_person_2.png", "images/access_person_3.png","images/access_person_4.png")
   
    final_message['data'] = message
    final_message['hide_controls'] = {"entrypoint.unlock_btn"}
  end
  
  if(id == "entrypoint_id3") then
    message = populate_entrypoint_values("entrypoint_id3", "Back Door","images/unlock.png","Unlocked","images/intrusion_toggle.png","on", 
            "images/toggle_off.png","off","images/access_person_1.png","images/access_person_2.png", "images/access_person_3.png","images/access_person_4.png")
   
    final_message['data'] = message
    final_message['hide_controls'] = {"entrypoint.unlock_btn"}
  end
  
  if(id == "entrypoint_id4") then
    message = populate_entrypoint_values("entrypoint_id4", "Bedroom Window","images/unlock.png","Unocked","images/intrusion_toggle.png","on", 
            "images/toggle_off.png","off","images/access_person_1.png","images/access_person_2.png", "images/access_person_3.png","images/access_person_4.png")
    
    final_message['data'] = message
    final_message['hide_controls'] = {"entrypoint.lock_btn", "entrypoint.unlock_btn"}
  end
  
  if(id == "entrypoint_id5") then
  
   message = populate_entrypoint_values("entrypoint_id5", "Kitchen Window","images/lock_icon.png","Locked","images/toggle_off.png","off", 
            "images/toggle_off.png","off","images/access_person_1.png","images/access_person_2.png", "images/access_person_3.png","")
   
    final_message['data'] = message
    final_message['hide_controls'] = {"entrypoint.lock_btn", "entrypoint.unlock_btn"}
  end
  
  if(id == "entrypoint_id6") then
   
    message = populate_entrypoint_values("entrypoint_id6", "Others","images/lock_icon.png","Locked","images/toggle_off.png","off", 
            "images/toggle_off.png","off","images/access_person_1.png","images/access_person_2.png", "images/access_person_3.png","")
   
    final_message['data'] = message
    final_message['hide_controls'] = {"entrypoint.lock_btn", "entrypoint.unlock_btn"}
  end
  
  --- Encodes the string as json
  --json_string = json.encode(final_message)
  return final_message
  
end

function populate_entrypoint_values(id, name, lock_icon, lock_text, intrustion_toggle_image, intrsution_toggle_text, 
        tamper_reaction_image, tamper_reaction_text, person1_img, person2_img, person3_img, person4_img)
    message = {}    
    message["entrypoint.id"] = id
    message["entrypoint.door_header_text.text"]=name
    message["entrypoint.lock_icon.lock_icon"]=lock_icon
    message["entrypoint.LOCKED.lock_unlock_text"]= lock_text
    message["entrypoint.tamper_toggle.key"]= "enable_status_change_reaction"
    message["entrypoint.tamper_toggle.toggle_on_off"]= tamper_reaction_image
    message["entrypoint.tamper_toggle.on_off"]=tamper_reaction_text
    message["entrypoint.intrusion_toggle.intrusion_on_off"]=intrustion_toggle_image
    message["entrypoint.intrusion_toggle.on_off"]=intrsution_toggle_text
    message["entrypoint.intrusion_toggle.key"]="should_monitor"
    message["entrypoint.access_person_1.access_person_1"]=person1_img
    message["entrypoint.access_person_2.access_person_2"]=person2_img
    message["entrypoint.access_person_3.access_person_3"]=person3_img
    message["entrypoint.access_person_3.access_person_4"]=person4_img
    
    return message
end
----------------------update_device_settings----------------------------

function update_device_settings(id, key, value)
  print("update the device settings for the id "..id .."for the key [".. key.."]" )
end

---------------action_lock_device----------------------

function action_lock_device(id, status)
  print("Lock the device for the id "..id .."for the status ["..status.."]")
end
