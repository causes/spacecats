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
*  **color**: A hex RGB string indicating the color of your cat

It responds with an integer indicating the fitness of your Spacecat

#### Examples
* A standard black cat:

        GET /galaxies/milky_way?weight=3&limbs=4&color=333333
        => 1

* A fictitious, yellow megacat:

        GET /galaxies/milky_way?weight=300&limbs=60&color=FFFF00
        => 0
