1. Bring it under FF `extra_payments`
2. Prevent paying for non-UK addresses

```ruby
return unless Flipper['extra_payments'].enabled?
raise "Unsupported address #{address.id}" unless address.in_uk?
```

```ruby
include_context 'when stubbing dependencies for', PaymentsContainer
```
