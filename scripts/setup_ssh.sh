# Define an array of remote hosts
REMOTE_HOSTS=("192.168.0.7")
USER="rene"

# Local SSH public key file
SSH_KEY="$HOME/.ssh/ssh_pi.pub"

# Check if the SSH public key exists
if [ ! -f "$SSH_KEY" ]; then
    echo "SSH key not found at $SSH_KEY. Please generate it with ssh-keygen."
    exit 1
fi

# Iterate over the array of hosts
for HOST in "${REMOTE_HOSTS[@]}"; do
    echo "Adding SSH key to $HOST..."
    
    # Use SSH and 'cat' to append the local public key to the remote authorized_keys
    cat "$SSH_KEY" | ssh "$USER@$HOST" 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys'
    
    # Check if the SSH key was added successfully
    if [ $? -eq 0 ]; then
        echo "SSH key successfully added to $HOST"
    else
        echo "Failed to add SSH key to $HOST"
    fi
done

echo "Process completed."