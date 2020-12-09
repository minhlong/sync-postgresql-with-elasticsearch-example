--  ss_products

create table ss_products
(
	id varchar(255) not null
		constraint ss_products_pkey
			primary key,
	shop_id integer not null,
	user_id bigint,
	ss_source_id integer,
	internal_id bigint not null,
	rest_id varchar(255),
	title varchar(255),
	description text,
	seo_title text,
	seo_description text,
	product_url text,
	image_url text,
	brand varchar(255),
	product_type text,
	variants jsonb,
	status_deleted varchar(255),
	type_action varchar(255),
	collection_ids json,
	published_at timestamp(0),
	is_deleted_copy boolean default false not null,
	created_at timestamp(0),
	updated_at timestamp(0)
);

create index ss_products_shop_id_index
	on ss_products (shop_id);

create index ss_products_internal_id_index
	on ss_products (internal_id);

create index ss_products_status_deleted_index
	on ss_products (status_deleted);

create index ss_products_published_at_index
	on ss_products (published_at);

--  ss_feed_products

create table if not exists ss_feed_products
(
	id varchar(255) not null
		constraint ss_feed_products_pkey
			primary key,
	ss_feed_id integer,
	ss_product_id varchar(255),
	rest_id varchar(255),
	offer_id varchar(100),
	title text,
	description text,
	other_fields jsonb,
	warnings jsonb,
	errors jsonb,
	app_errors jsonb,
	destination_statuses jsonb,
	item_level_issues jsonb,
	is_submit boolean default true not null,
	is_fetch boolean default true not null,
	status_deleted varchar(255),
	type_action varchar(255),
	status varchar(255),
	is_deleted_copy boolean default false not null,
	last_fetch timestamp(0) default CURRENT_TIMESTAMP not null,
	created_at timestamp(0),
	updated_at timestamp(0)
);

-- Table: public.ss_feeds

CREATE TABLE public.ss_feeds
(
    id integer NOT NULL,
    shop_id integer NOT NULL,
    ss_social_account_id integer NOT NULL,
    name character varying(255) COLLATE pg_catalog."default",
    account_center_id character varying(255) COLLATE pg_catalog."default",
    center_id character varying(255) COLLATE pg_catalog."default",
    data_source_id character varying(255) COLLATE pg_catalog."default",
    account_center_name character varying(255) COLLATE pg_catalog."default",
    center_name character varying(255) COLLATE pg_catalog."default",
    target_market character varying(5) COLLATE pg_catalog."default",
    content_language character varying(5) COLLATE pg_catalog."default",
    utm_tag jsonb,
    auto_refresh_at character varying(10) COLLATE pg_catalog."default",
    auto_refresh_period character varying(10) COLLATE pg_catalog."default",
    auto_refresh_submit_run_time timestamp(0) without time zone,
    auto_refresh_fetch_run_time timestamp(0) without time zone,
    timezone character varying(255) COLLATE pg_catalog."default",
    auto_apply_mapping boolean NOT NULL DEFAULT true,
    type_get_product character varying(255) COLLATE pg_catalog."default",
    collection_ids json,
    collection_categories jsonb,
    filter_statement jsonb,
    show_columns jsonb,
    last_submit timestamp(0) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_fetch timestamp(0) without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    manual_submit boolean NOT NULL DEFAULT false,
    status character varying(255) COLLATE pg_catalog."default" NOT NULL DEFAULT 'ACTIVATED'::character varying,
    processing character varying(255) COLLATE pg_catalog."default",
    is_re_assign boolean NOT NULL DEFAULT false,
    check_migrate boolean NOT NULL DEFAULT true,
    is_uninstall boolean NOT NULL DEFAULT false,
    check_migrate_categories boolean NOT NULL DEFAULT true,
    social_type character varying(255) COLLATE pg_catalog."default",
    shop_ids json,
    rules jsonb,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    user_id integer DEFAULT 0,
    schedule character varying(10) COLLATE pg_catalog."default",
    fbe_ids jsonb,
    CONSTRAINT ss_feeds_pkey PRIMARY KEY (id)
)
