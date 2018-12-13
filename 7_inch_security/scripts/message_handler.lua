json = require "json"

--------------------------Messages to server -----------------------------
function load_home_page(mapargs) 
  send_event("load_home_screen")
end


------------------------- Handle messages from server  ----------------------------

function message_received_from_server(mapargs) 
   local data_dict = {}
   local message = mapargs.context_event_data.data;
   --data_dict = handle_message(message);
   data_dict = handle_message_with_json(message);
 end

function handle_message_with_json(message)
   --data_table = json.decode(message)
   --print_table(data_table)
   
   data_values = message['data']
   print('handling the message with json')
   print_table(data_values)
   hide_controls = message["hide_controls"]
   show_hide_controls(1, hide_controls)
   gre.set_data(data_values)
   return data_values
end

function handle_message(message) 
   local data_dict = {}
   print("Incoming message from the server: "..message)
   local value=split(message, ",")   -- Split based on commas
    -- Split based on = and add to data dict
    for i=1,#value do                                       
        local split_result = split(value[i],"=")
        --print(split_result[1].."---"..split_result[2])
        data_dict[split_result[1]] = split_result[2];
   end
  
   if(data_dict["messageType"]=="navTableInfo") then
      --print("------Handle navTable message type-----");
      load_nav_table(data_dict)
   elseif(data_dict["messageType"]=="prefTableInfo") then
      --print("------Handle prefTable message type-----");
      load_pref_table(data_dict)
   elseif(data_dict["messageType"] == "animation")  then
     --print("------Handle animation message type-----");
      handle_animation(data_dict)
   else
   -- print("------Handle normal data message type-----");
     gre.set_data(data_dict);
   end
   return data_dict;
end

function handle_message_with_timer(message, timer_func, timer_interval) 
   local data_dict = {}
   print("Incoming message from the server: "..message)
   local value=split(message, ",")   -- Split based on commas
    -- Split based on = and add to data dict
    for i=1,#value do                                       
        local split_result = split(value[i],"=")
        --print(split_result[1].."---"..split_result[2])
        data_dict[split_result[1]] = split_result[2];
   end
   gre.set_data(data_dict);
   
   gre.timer_set_interval(timer_func,timer_interval);
   return data_dict;
end