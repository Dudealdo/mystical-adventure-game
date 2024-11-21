grammar game_logic;

action: 'ON' event 'WITH' object 'DO' command;
event: 'player_interact' | 'enter_realm';
object: 'portal' | 'npc';
command: 'OPEN next_scene' | 'GIVE quest';
