# Installation

`bundle install`
`bundle exec rspec`

# Problem

1. Bring it under FF `support_hardcopy`
2. Always applied for UK addresses

| in UK | FF    | Result|
|-------|-------|-------|
| true  | true  | true  |
| true  | false | true  |
| false | true  | true  |
| false | false | false |

```ruby
Command.save(invoice).tap { |result|
  create_invoice_hardcopy.call(invoice: result) if address.in_uk? || Flipper['support_hardcopy'].enabled?
}
```

```ruby
include_context 'when stubbing dependencies for', PaymentsContainer
```
