#ifndef IO_H
#define IO_H

// TODO: enums

#define LAUNCHPAD

typedef enum {
#if defined(LAUNCHPAD)
  IO_TEST_LED,
  IO_kzUART_RXD,
  IO_UART_TXD,
  IO_UNUSED_1,
  IO_UNUSED_2,
  IO_UNUSED_3,
  IO_UNUSED_4,
  IO_UNUSED_5,
  IO_UNUSED_6,
  IO_UNUSED_7,
  IO_UNUSED_8,
  IO_UNUSED_9,
  IO_UNUSED_10,
  IO_UNUSED_11,
  IO_UNUSED_12,
  IO_UNUSED_13,
#elif defined(SUMO)
#endif
} io_e;

typedef enum {
  IO_SELECT_GPIO,
  IO_SELECT_ALT1,
  IO_SELECT_ALT2,
  IO_SELECT_ALT3,
} io_select_e;

typedef enum {
  IO_DIR_OUTPUT,
  IO_DIR_INPUT,
} io_dir_e;

typedef enum {
  IO_RESISTOR_DISABLED,
  IO_RESISTOR_ENABLED,
}io_resistor_e;

typedef enum {
  IO_OUT_LOW,   // pull-down
  IO_OUT_HIGH,  // pull-up 
}io_out_e;

typedef enum {
  IO_IN_LOW,
  IO_IN_HIGH,
}io_in_e;

// TODO: structs

// TODO: functions

void io_set_select(io_e io, io_select_e select); //select the function of the pin
void io_set_dir(io_e io, io_dir_e direction); // direction of pin : input - output
void io_set_resistor(io_e io, io_resistor_e resistor); // enable pull-resistor
void io_set_out(io_e io, io_out_e out); //set pull-resistor direction : down - up
io_in_e io_get_input(io_e io);

#endif