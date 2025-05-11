# CLI Application

A command-line interface application built with Ruby.

## Setup

1. Install dependencies:
```bash
bundle install
```

2. Make the CLI executable:
```bash
chmod +x bin/cli
```

## Usage

The CLI provides the following commands:

- `./bin/cli search <query>` - Search for clients by name
  - Example: `./bin/cli search "John"` will find all clients with "John" in their name
  - The search is case-insensitive and matches partial names

- `./bin/cli find_duplicates` - Find duplicate email addresses in the client database
  - Lists all email addresses that are used by multiple clients
  - Shows the full name and ID of each client sharing the same email

## Development

This project uses Rubocop for code style enforcement. To run the linter:

```bash
bundle exec rubocop
```

## Specs

The tests can be run through the following code:

```bash
bundle exec rspec spec
```

## Assumptions:
1. The clients file is saved on the same directory.
2. Search and duplicate search are case insensitive.