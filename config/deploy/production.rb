set :ssh_options, {
    user: fetch(:user),
    keys: %w(/home/an/.ssh/digitalocean),
    forward_agent: true,
    keys_only: true,
    config: true
}