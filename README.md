# Skrappy

Skrappy is a tool that identifies possibly fraudlent reviews at dealerrater.com

## Hot it works

The review goes through an analyzer that looks for specific words in it. Each word has a score, and for each word found in the review this score is added to the `fraud_level` review attribute.

The keywords and its score are:

| Keyword     | Score |
| ----------- | ----- |
| awesome     | 60    |
| best        | 90    |
| great       | 40    |
| amazing     | 50    |
| happy       | 50    |
| experience  | 20    |
| exceptional | 100   |
| recommend   | 60    |
| helped      | 40    |
| nice        | 30    |

## Installation

Skrappy depends on:

- Elixir 1.12.1
- Erlang 23.1.1

Just go through https://elixir-lang.org/install.html and you'll probably good to go.

## Usage

Start the application in interactive mode:

```
iex -S mix
```

At the interactive shell just go with:

```elixir
Skrappy.fraud_detect()
```

## Tests

To run all tests just use:

```
mix test
```
