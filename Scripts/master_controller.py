import os

def activate_engine(engine_name):
    engines = {
        "scene_transition": "Activating Scene Transition Engine...",
        "path_development": "Activating Path Development Engine...",
        "npc_companion": "Activating NPC and Companion Engine..."
    }
    print(engines.get(engine_name, "Unknown engine"))

def main():
    print("Master Controller Active")
    while True:
        command = input("Enter command to activate engine (or 'exit' to quit): ")
        if command == "exit":
            break
        activate_engine(command)

if __name__ == "__main__":
    main()
