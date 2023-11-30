# Living Norrath

## Clone the Repository

```bash
git clone https://github.com/dangle/living-norrath.git
cd living-norrath
```

## Manual Installation

This assumes your server was installed using the [Basic Server Install - Linux](https://docs.eqemu.io/server/installation/server-installation-linux/) on a Debian-based system

### Prerequisites

Run the following commands to get the prerequisites installed:

```bash
sudo apt update
sudo apt install -y luarocks rsync
sudo luarocks install lua-openai
sudo luarocks install lunajson
```

### Copy Files to the EQEmu Installation

Copy over all of the server files

```bash
sudo -u eqemu rsync -vr server/  ~eqemu/

```

### Configuration

Create an [OpenAI API key](https://platform.openai.com/api-keys).

Add your OpenAI API key to the end of your `eqemu_config.json` file:

```json
"gptnpc": {
  "apikey": "<YOUR OPENAI API KEY>",
}
```

## Available Configuration Options

All values must be placed in the file `eqemu_config.json`.

| Option             | Required | Default Value |
| ------------------ | -------- | ------------- |
| gptnpc.apikey      | Yes      |               |
| gptnpc.model       | No       | gpt-3.5-turbo |
| gptnpc.temperature | No       | 0.2           |
