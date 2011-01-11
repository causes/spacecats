# SPACECATS!
_Explore the universe of optimal cattednes._

## API

### List galaxies
`GET /galaxies` responds with a comma-separated list of known galaxies

#### Example
    GET /galaxies
    => milky_way,andromeda

---

### Fitness
`GET /galaxies/<galaxy>` is a fitness function that expects three parameters:

*  **weight**: The weight of your Spacecat, between 1 and 1000 kg
*  **limbs**: The number of limbs your Spacecat has, between 0 and 100
*  **color**: A hex RGB string indicating the color of your Spacecat
*  **batch**: _(optional)_ `true` if you're submitting a batch of attributes

It responds with an integer indicating the fitness of your Spacecat.

#### Batching
By including `batch=true` in your request, you can submit batches of Spacecat
attributes to be evaluated all at once. The response becomes a
comma-separated list of all fitnesses.

#### Examples
* A standard black cat:

        GET /galaxies/milky_way?weight=3&limbs=4&color=333333
        => 1

* A fictitious, yellow megacat:

        GET /galaxies/milky_way?weight=300&limbs=60&color=FFFF00
        => 0

* Both in a batch:

        GET /galaxies/milky_way?batch=true&weight=3,300&limbs=4,60&color=333333,FFFF00
        => 1,0
