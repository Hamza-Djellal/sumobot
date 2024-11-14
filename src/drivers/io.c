#include "drivers/io.h"
#include "common/defines.h"

void io_set_select(io_e io, io_select_e select) {
  UNUSED(io);
  UNUSED(select);
  // TODO: Implementation
}

void io_set_dir(io_e io, io_dir_e direction) {
  UNUSED(io);
  UNUSED(direction);
  // TODO: Implementation
}

void io_set_resistor(io_e io, io_resistor_e resistor) {
  UNUSED(io);
  UNUSED(resistor);
  // TODO: Implementation
}

void io_set_out(io_e io, io_out_e out) {
  UNUSED(io);
  UNUSED(out);
  // TODO: Implementation
}

io_in_e io_get_input(io_e io) {
  UNUSED(io);
  // TODO: Implementation
  return 0;
}