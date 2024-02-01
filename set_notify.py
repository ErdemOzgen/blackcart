import sys
import yaml

def update_telegram_config_in_file(file_path, new_api_key, new_chat_id):
    """
    Updates the Telegram API key and chat ID in a YAML configuration file.

    Args:
    - file_path (str): The path to the YAML configuration file.
    - new_api_key (str): The new Telegram API key to set.
    - new_chat_id (str): The new Telegram chat ID to set.
    """
    # Read the existing configuration from the file
    with open(file_path, 'r') as file:
        config = yaml.safe_load(file)
    
    # Update the Telegram configuration
    for item in config['telegram']:
        if item['id'] == 'tel':  # Check if this is the Telegram configuration
            item['telegram_api_key'] = new_api_key
            item['telegram_chat_id'] = new_chat_id
    
    # Write the updated configuration back to the file
    with open(file_path, 'w') as file:
        yaml.safe_dump(config, file)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python main.py TELEGRAM_API_KEY TELEGRAM_CHAT_ID")
        sys.exit(1)

    # Extract command-line arguments
    new_api_key = sys.argv[1]
    new_chat_id = sys.argv[2]
    
    # Define the path to your YAML configuration file
    file_path = '/root/.config/notify/provider-config.yaml'
    
    # Update the configuration file with the new API key and chat ID
    update_telegram_config_in_file(file_path, new_api_key, new_chat_id)
