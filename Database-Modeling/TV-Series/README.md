# TV Series ER Diagram

This folder contains an entity-relationship model for a television-series database. It describes how productions are organized into seasons and episodes and how fictional characters and actors are associated with those productions.

## Files

- [TV-Series-ER-Diagram.pdf](TV-Series-ER-Diagram.pdf) - exported diagram for viewing or printing
- [TV-Series-ER-Diagram.drawio](TV-Series-ER-Diagram.drawio) - editable draw.io source

## Main Entities

- **Seasons** - identifies a season by production name, season number, and start and end dates.
- **Episodes** - stores an episode number, air date, and duration.
- **Characters** - identifies a character by character number, name, and role.
- **Actors** - stores the actor name associated with a character.

## Relationships

- A production contains seasons.
- A season contains episodes.
- Characters participate in a production and can be connected to the episodes in which they appear.
- An actor is associated with a character, while the character’s role describes that character within the production.

The underlined attributes in the diagram represent identifying attributes, including production name, season number, episode number, and character number. These identifiers provide the basis for linking seasons, episodes, characters, and actors in a relational implementation.

## Primary Keys

The underlined attributes shown as identifiers in the diagram are:

| Entity | Primary key |
| --- | --- |
| Seasons | `имеНаПродукция` and `номерСезон` |
| Episodes | `номерЕпизод` |
| Characters | `номерГерой` |

The season identifier is represented by the production name together with the season number. The episode and character numbers identify their corresponding records in the diagram. When implementing the model, confirm whether episode numbers are unique globally or should be combined with a season or production key.

## Purpose

The model can be used to design tables for productions, seasons, episodes, characters, and actors; define primary and foreign keys; and represent participation relationships without duplicating episode or character data. The PDF is the rendered reference, while the draw.io file can be edited when the model changes.
