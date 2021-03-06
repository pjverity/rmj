CREATE TABLE orders
(
  id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY (START WITH 0, INCREMENT BY 1),
  users_id INTEGER REFERENCES users (id),
  purchase_time TIMESTAMP WITH DEFAULT CURRENT TIMESTAMP,
  unit_cost DECIMAL NOT NULL,
  quantity INTEGER NOT NULL
);