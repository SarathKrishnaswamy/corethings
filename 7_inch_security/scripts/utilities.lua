--------- Print Utilities ---------
function print_table(table) 
if(table ~= nil) then
  for k,v in pairs(table) do
    if( v~= nil ) then
      print(k.."="..v);
    else 
      print(k.."=")
     end
  end
end
end

------------Split Utilties ---------

function split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

--- GRE Events -------
function send_event(event)
  print("Outgoing message for the server:"..event)
  --Uncomment here to sent it to back-end
  --gre.send_event(event, "backend_channel")
  test_send(event)
end

------------- Animation Utilties --------------------------------

function handle_animation(data_dict) 
  local animation_id = data_dict["id"]
  local animation_stop = data_dict["stop"]
  if(animation_stop ~= nil) then
    stop_animation(animation_id)
  else
    start_animation(animation_id)
  end
end


function start_animation(animation_id)
  --print("------Start the animation"..animation_id)
  gre.animation_trigger(animation_id);
end

function stop_animation(animation_id)
  --print("------Stopping the animation"..animation_id)
  gre.animation_destroy(animation_id);
end
