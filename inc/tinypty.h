void init_pty();
void configure_pty_raw_mode();
void pty_write_byte(char c);
void pty_write_str(const char *str);
char pty_read_byte();
