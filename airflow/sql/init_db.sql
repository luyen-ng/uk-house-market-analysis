-------------CREATE TABLES------------------------
drop table if exists public.house_price cascade;

create table public.house_price (
    id SERIAL primary key,
    transaction_unique_identifier varchar(50) not null,
    price int not null,
    date_of_transfer date not null,
    postcode varchar(10) null,
    property_type varchar(50) null,
    new_build varchar(50) null,
    tenure varchar(50) null,
    street varchar(255) null,
    district varchar(255) null,
    town_city varchar(255) null,
    county varchar(255) null,
    lsmdf timestamp default current_timestamp
);

CREATE INDEX idx_postcode ON house_price (postcode);

drop table if exists public.house_adjusted_price cascade;

create table public.house_adjusted_price (
	id bigint NULL,
	price int NULL,
	adjusted_price numeric(22,2) NULL,
	date_of_transfer date NULL,
	month_of_transfer date NULL,
	postcode varchar(10) NULL,
	property_type varchar(50) NULL,
	new_build varchar(50) NULL,
	tenure varchar(50) NULL,
	street varchar(255) NULL,
	district varchar(255) NULL,
	town_city varchar(255) NULL,
	county varchar(255) NULL,
	lsmdf timestamp default current_timestamp
);

drop table if exists public.cpi cascade;

create table public.cpi (
    id SERIAL primary key,
    cpi_month date not null,
	value numeric(10,2) not null,
    lsmdf timestamp default current_timestamp
);

drop table if exists public.predicted_monthly_price  cascade;

create table public.predicted_monthly_price (
    month_of_transfer date not null,
    category varchar(255) not null,
    subcategory varchar(255) not null,
    label varchar(255) not null,
    price numeric(22,2) not null,
    model varchar(255) null,
    lsmdf timestamp default current_timestamp
);

drop table if exists public.calculated_metric  cascade;

create table public.calculated_metric (
    category varchar(255) not null,
    subcategory varchar(255) not null,
    model varchar(255) not null,
    mape numeric(10,2) not null,
    mae numeric(22,2) not null,
    rmse numeric(22,2) not null,
    r2 numeric(22,2) not null,
    mbe numeric(22,2) not null,
    da numeric(10,2) null,
    lsmdf timestamp default current_timestamp
);

-------------INSERT CPI data------------------------
truncate table public.cpi;
insert into public.cpi (cpi_month, value) values ('2019/01/01', 106.4);
insert into public.cpi (cpi_month, value) values ('2019/02/01', 106.8);
insert into public.cpi (cpi_month, value) values ('2019/03/01', 107);
insert into public.cpi (cpi_month, value) values ('2019/04/01', 107.6);
insert into public.cpi (cpi_month, value) values ('2019/05/01', 107.9);
insert into public.cpi (cpi_month, value) values ('2019/06/01', 107.9);
insert into public.cpi (cpi_month, value) values ('2019/07/01', 108);
insert into public.cpi (cpi_month, value) values ('2019/08/01', 108.3);
insert into public.cpi (cpi_month, value) values ('2019/09/01', 108.4);
insert into public.cpi (cpi_month, value) values ('2019/10/01', 108.3);
insert into public.cpi (cpi_month, value) values ('2019/11/01', 108.5);
insert into public.cpi (cpi_month, value) values ('2019/12/01', 108.5);
insert into public.cpi (cpi_month, value) values ('2020/01/01', 108.3);
insert into public.cpi (cpi_month, value) values ('2020/02/01', 108.6);
insert into public.cpi (cpi_month, value) values ('2020/03/01', 108.6);
insert into public.cpi (cpi_month, value) values ('2020/04/01', 108.6);
insert into public.cpi (cpi_month, value) values ('2020/05/01', 108.6);
insert into public.cpi (cpi_month, value) values ('2020/06/01', 108.8);
insert into public.cpi (cpi_month, value) values ('2020/07/01', 109.2);
insert into public.cpi (cpi_month, value) values ('2020/08/01', 108.8);
insert into public.cpi (cpi_month, value) values ('2020/09/01', 109.2);
insert into public.cpi (cpi_month, value) values ('2020/10/01', 109.2);
insert into public.cpi (cpi_month, value) values ('2020/11/01', 109.1);
insert into public.cpi (cpi_month, value) values ('2020/12/01', 109.4);
insert into public.cpi (cpi_month, value) values ('2021/01/01', 109.3);
insert into public.cpi (cpi_month, value) values ('2021/02/01', 109.4);
insert into public.cpi (cpi_month, value) values ('2021/03/01', 109.7);
insert into public.cpi (cpi_month, value) values ('2021/04/01', 110.4);
insert into public.cpi (cpi_month, value) values ('2021/05/01', 111);
insert into public.cpi (cpi_month, value) values ('2021/06/01', 111.4);
insert into public.cpi (cpi_month, value) values ('2021/07/01', 111.4);
insert into public.cpi (cpi_month, value) values ('2021/08/01', 112.1);
insert into public.cpi (cpi_month, value) values ('2021/09/01', 112.4);
insert into public.cpi (cpi_month, value) values ('2021/10/01', 113.4);
insert into public.cpi (cpi_month, value) values ('2021/11/01', 114.1);
insert into public.cpi (cpi_month, value) values ('2021/12/01', 114.7);
insert into public.cpi (cpi_month, value) values ('2022/01/01', 114.6);
insert into public.cpi (cpi_month, value) values ('2022/02/01', 115.4);
insert into public.cpi (cpi_month, value) values ('2022/03/01', 116.5);
insert into public.cpi (cpi_month, value) values ('2022/04/01', 119);
insert into public.cpi (cpi_month, value) values ('2022/05/01', 119.7);
insert into public.cpi (cpi_month, value) values ('2022/06/01', 120.5);
insert into public.cpi (cpi_month, value) values ('2022/07/01', 121.2);
insert into public.cpi (cpi_month, value) values ('2022/08/01', 121.8);
insert into public.cpi (cpi_month, value) values ('2022/09/01', 122.3);
insert into public.cpi (cpi_month, value) values ('2022/10/01', 124.3);
insert into public.cpi (cpi_month, value) values ('2022/11/01', 124.8);
insert into public.cpi (cpi_month, value) values ('2022/12/01', 125.3);
insert into public.cpi (cpi_month, value) values ('2023/01/01', 124.8);
insert into public.cpi (cpi_month, value) values ('2023/02/01', 126);
insert into public.cpi (cpi_month, value) values ('2023/03/01', 126.8);
insert into public.cpi (cpi_month, value) values ('2023/04/01', 128.3);
insert into public.cpi (cpi_month, value) values ('2023/05/01', 129.1);
insert into public.cpi (cpi_month, value) values ('2023/06/01', 129.4);
insert into public.cpi (cpi_month, value) values ('2023/07/01', 129);
insert into public.cpi (cpi_month, value) values ('2023/08/01', 129.4);
insert into public.cpi (cpi_month, value) values ('2023/09/01', 130.1);
insert into public.cpi (cpi_month, value) values ('2023/10/01', 130.2);
insert into public.cpi (cpi_month, value) values ('2023/11/01', 130);
insert into public.cpi (cpi_month, value) values ('2023/12/01', 130.5);
insert into public.cpi (cpi_month, value) values ('2024/01/01', 130);
insert into public.cpi (cpi_month, value) values ('2024/02/01', 130.8);
insert into public.cpi (cpi_month, value) values ('2024/03/01', 131.6);
insert into public.cpi (cpi_month, value) values ('2024/04/01', 132.2);
insert into public.cpi (cpi_month, value) values ('2024/05/01', 132.7);
insert into public.cpi (cpi_month, value) values ('2024/06/01', 133);
insert into public.cpi (cpi_month, value) values ('2024/07/01', 132.9);
insert into public.cpi (cpi_month, value) values ('2024/08/01', 133.4);
insert into public.cpi (cpi_month, value) values ('2024/09/01', 133.5);
insert into public.cpi (cpi_month, value) values ('2024/10/01', 134.3);
insert into public.cpi (cpi_month, value) values ('2024/11/01', 134.6);
insert into public.cpi (cpi_month, value) values ('2024/12/01', 135.1);
insert into public.cpi (cpi_month, value) values ('2025/01/01', 135.1);
insert into public.cpi (cpi_month, value) values ('2025/02/01', 135.6);
insert into public.cpi (cpi_month, value) values ('2025/03/01', 136.1);
insert into public.cpi (cpi_month, value) values ('2025/04/01', 137.7);
insert into public.cpi (cpi_month, value) values ('2025/05/01', 138);
insert into public.cpi (cpi_month, value) values ('2025/06/01', 138.4);




