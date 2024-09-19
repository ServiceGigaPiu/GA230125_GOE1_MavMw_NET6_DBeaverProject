delimiter $$

-- TOOLS LIB --

DROP PROCEDURE IF EXISTS devdb.tools_dropAllfkFromTable$$
CREATE DEFINER=`dev`@`%` PROCEDURE devdb.tools_dropAllfkFromTable (IN param_table_schema varchar(255), IN param_table_name varchar(255))
begin
    declare done int default FALSE;
    declare dropCommand varchar(255);
    declare dropCur cursor for 
        select concat('alter table ',table_schema,'.',table_name,' DROP FOREIGN KEY ',constraint_name, ';') 
        from information_schema.table_constraints
        where constraint_type='FOREIGN KEY' 
            and table_name = param_table_name
            and table_schema = param_table_schema;

    declare continue handler for not found set done = true;

    open dropCur;

    read_loop: loop
        fetch dropCur into dropCommand;
        if done then
            leave read_loop;
        end if;

        set @sdropCommand = dropCommand;

        prepare dropClientUpdateKeyStmt from @sdropCommand;

        execute dropClientUpdateKeyStmt;

        deallocate prepare dropClientUpdateKeyStmt;
    end loop;

    close dropCur;
end$$

-- END TOOLS LIB --

delimiter ;
;