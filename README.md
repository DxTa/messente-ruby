# MESSENTE RUBY

## Installation

```sh
gem install messente-ruby
```

## Usage

```rb
messente = Messente.new({
    username: ENV['MESSENTE_USERNAME'],
    password: ENV['MESSENTE_PASSWORD']
})

resp = messente.verify_start({
    to: params[:phone]
})

resp = messente.send({
    from: "MyDelivery",
    to: "+44000000000",
    text: "Your parcel will be delivered at 10AM"
})

if resp[:error].nil?
    render status: 200
else
    render status: 400
end
```

## Contributtion

This is very first version of the gem. I made it while working in one project. PRs are welcomes!