# London Transportation

## Description

Solution for the London Trasportation Challenge, which is a limited version of London’s Oyster card system. It does not consider the real-world constraints of the system, for example: Fare readers may not have network access (i.e., attached to a bus).

## Ruby Version

version 2.7.6

## How to Run the Script

To run the example script follow these steps:

- Navigate to the project directory where the `run.rb` file is located.

- Run the script by executing the following command:

   ```shell
   ruby run.rb
   ```

## Example of the script

The script demonstrates a user loading a card with £30, and taking the following trips:

```text
Tube Holborn to Earl’s Court
328 bus from Earl’s Court to Chelsea
Tube Chelsea to Wimbledon
```
it will modify the user balance as it is expected. 

```text
Expected Balance: £22.50
```

## How to Run the Tests
Run the tests by executing the following commands:

   ```shell
   bundle install
   rspec
   ```
