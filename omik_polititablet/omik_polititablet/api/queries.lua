--[[
#########################################################
# ██████╗ ███╗   ███╗██╗██╗  ██╗██╗  ██╗███████╗██╗     #
#██╔═══██╗████╗ ████║██║██║ ██╔╝██║ ██╔╝██╔════╝██║     #
#██║   ██║██╔████╔██║██║█████╔╝ █████╔╝ █████╗  ██║     #
#██║   ██║██║╚██╔╝██║██║██╔═██╗ ██╔═██╗ ██╔══╝  ██║     #
#╚██████╔╝██║ ╚═╝ ██║██║██║  ██╗██║  ██╗███████╗███████╗#
# ╚═════╝ ╚═╝     ╚═╝╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝#
#########################################################
--]]
-- Script: omik_polititablet V2
-- Author: OMikkel#3217

queries = {}

queries.applications = {
    esx = {
        ["/applications_forms"] = {
            type = "SELECT",
            table = "omik_polititablet_ansogninger_forms",
            fields = {
                id = "id",
                structure = "structure"
            }
        },
        ["/applications_form_create"] = {
            type = "INSERT",
            table = "omik_polititablet_ansogninger_forms",
            table_cols = "(id, officer_id, structure, date)",
            insert_fields = "(NULL, @officer_id, @structure, NULL)"
        },
        ["/applications_form_update"] = {
            type = "UPDATE",
            table = "omik_polititablet_ansogninger_forms",
            update_fields = {"structure = @structure"},
            where = "id = @id"
        },
        ["/applications_form_delete"] = {
            type = "DELETE",
            table = "omik_polititablet_ansogninger_forms",
            where = "id = @id"
        },
        ["/applications_answers_create"] = {
            type = "INSERT",
            table = "omik_polititablet_ansogninger",
            table_cols = "(id, formID, officer_id, structure, date)",
            insert_fields = "(NULL, @formID, @officer_id, @structure, NULL)"
        },
        ["/applications_answers"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_ansogninger ans",
            fields = {
                ["ans.id"] = "id",
                ["ans.formID"] = "formID",
                ["ans.officer_id"] = "officer_id",
                ["ans.structure"] = "structure",
                ["ans.date"] = "date",
                ["an.badge_number"] = "badge_number",
                ["an.rank"] = "rank",
                ["CONCAT(u.firstname, ' ', u.lastname)"] = "name"
            },
            joins = {
                "LEFT JOIN omik_polititablet_ansatte an ON an.officer_id = ans.officer_id",
                "LEFT JOIN users u ON u.officer_id = ans.officer_id"
            },
            where = "ans.formID = @formID"
        },
        ["/applications_answers_delete"] = {
            type = "DELETE",
            table = "omik_polititablet_ansogninger",
            where = "id = @id"
        },
        ["/applications_answers_accept_certificates"] = {
            type = "UPDATE",
            table = "omik_polititablet_ansatte",
            update_fields = {"certificates = JSON_ARRAY_APPEND(certificates, '$', @certificate)"},
            where = "officer_id = @officer_id"
        },
        ["/applications_answers_accept_educations"] = {
            type = "UPDATE",
            table = "omik_polititablet_ansatte",
            update_fields = {"educations = JSON_ARRAY_APPEND(educations, '$', @education)"},
            where = "officer_id = @officer_id"
        },
        ["/applications_user_answers"] = {
            type = "SELECT",
            table = "omik_polititablet_ansogninger",
            fields = {
                id = "id",
                formID = "formID",
                officer_id = "officer_id",
                structure = "structure",
                date = "date"
            },
            where = "officer_id = @officer_id"
        },
        ["/applications_user_answer_update"] = {
            type = "UPDATE",
            table = "omik_polititablet_ansogninger",
            update_fields = {"structure = @structure"},
            where = "id = @id"
        }
    },
    vrp = {
        ["/applications_forms"] = {
            type = "SELECT",
            table = "omik_polititablet_ansogninger_forms",
            fields = {
                id = "id",
                structure = "structure"
            }
        },
        ["/applications_form_create"] = {
            type = "INSERT",
            table = "omik_polititablet_ansogninger_forms",
            table_cols = "(id, officer_id, structure, date)",
            insert_fields = "(NULL, @officer_id, @structure, NULL)"
        },
        ["/applications_form_update"] = {
            type = "UPDATE",
            table = "omik_polititablet_ansogninger_forms",
            update_fields = {"structure = @structure"},
            where = "id = @id"
        },
        ["/applications_form_delete"] = {
            type = "DELETE",
            table = "omik_polititablet_ansogninger_forms",
            where = "id = @id"
        },
        ["/applications_answers_create"] = {
            type = "INSERT",
            table = "omik_polititablet_ansogninger",
            table_cols = "(id, formID, officer_id, structure, date)",
            insert_fields = "(NULL, @formID, @officer_id, @structure, NULL)"
        },
        ["/applications_answers"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_ansogninger ans",
            fields = {
                ["ans.id"] = "id",
                ["ans.formID"] = "formID",
                ["ans.officer_id"] = "officer_id",
                ["ans.structure"] = "structure",
                ["ans.date"] = "date",
                ["an.badge_number"] = "badge_number",
                ["an.rank"] = "rank",
                ["CONCAT(u.firstname, ' ', u.name)"] = "name"
            },
            joins = {
                "LEFT JOIN omik_polititablet_ansatte an ON an.officer_id = ans.officer_id",
                "LEFT JOIN vrp_user_identities u ON u.officer_id = ans.officer_id"
            },
            where = "ans.formID = @formID"
        },
        ["/applications_answers_delete"] = {
            type = "DELETE",
            table = "omik_polititablet_ansogninger",
            where = "id = @id"
        },
        ["/applications_answers_accept_certificates"] = {
            type = "UPDATE",
            table = "omik_polititablet_ansatte",
            update_fields = {"certificates = JSON_ARRAY_APPEND(certificates, '$', @certificate)"},
            where = "officer_id = @officer_id"
        },
        ["/applications_answers_accept_educations"] = {
            type = "UPDATE",
            table = "omik_polititablet_ansatte",
            update_fields = {"educations = JSON_ARRAY_APPEND(educations, '$', @education)"},
            where = "officer_id = @officer_id"
        },
        ["/applications_user_answers"] = {
            type = "SELECT",
            table = "omik_polititablet_ansogninger",
            fields = {
                id = "id",
                formID = "formID",
                officer_id = "officer_id",
                structure = "structure",
                date = "date"
            },
            where = "officer_id = @officer_id"
        },
        ["/applications_user_answer_update"] = {
            type = "UPDATE",
            table = "omik_polititablet_ansogninger",
            update_fields = {"structure = @structure"},
            where = "id = @id"
        }
    },
    qbcore = {
        ["/applications_forms"] = {
            type = "SELECT",
            table = "omik_polititablet_ansogninger_forms",
            fields = {
                id = "id",
                structure = "structure"
            }
        },
        ["/applications_form_create"] = {
            type = "INSERT",
            table = "omik_polititablet_ansogninger_forms",
            table_cols = "(id, officer_id, structure, date)",
            insert_fields = "(NULL, @officer_id, @structure, NULL)"
        },
        ["/applications_form_update"] = {
            type = "UPDATE",
            table = "omik_polititablet_ansogninger_forms",
            update_fields = {"structure = @structure"},
            where = "id = @id"
        },
        ["/applications_form_delete"] = {
            type = "DELETE",
            table = "omik_polititablet_ansogninger_forms",
            where = "id = @id"
        },
        ["/applications_answers_create"] = {
            type = "INSERT",
            table = "omik_polititablet_ansogninger",
            table_cols = "(id, formID, officer_id, structure, date)",
            insert_fields = "(NULL, @formID, @officer_id, @structure, NULL)"
        },
        ["/applications_answers"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_ansogninger ans",
            fields = {
                ["ans.id"] = "id",
                ["ans.formID"] = "formID",
                ["ans.officer_id"] = "officer_id",
                ["ans.structure"] = "structure",
                ["ans.date"] = "date",
                ["an.badge_number"] = "badge_number",
                ["an.rank"] = "rank",
                ["CONCAT(JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname')))"] = "name"
            },
            joins = {
                "LEFT JOIN omik_polititablet_ansatte an ON an.officer_id = ans.officer_id",
                "LEFT JOIN players u ON u.officer_id = ans.officer_id"
            },
            where = "ans.formID = @formID"
        },
        ["/applications_answers_delete"] = {
            type = "DELETE",
            table = "omik_polititablet_ansogninger",
            where = "id = @id"
        },
        ["/applications_answers_accept_certificates"] = {
            type = "UPDATE",
            table = "omik_polititablet_ansatte",
            update_fields = {"certificates = JSON_ARRAY_APPEND(certificates, '$', @certificate)"},
            where = "officer_id = @officer_id"
        },
        ["/applications_answers_accept_educations"] = {
            type = "UPDATE",
            table = "omik_polititablet_ansatte",
            update_fields = {"educations = JSON_ARRAY_APPEND(educations, '$', @education)"},
            where = "officer_id = @officer_id"
        },
        ["/applications_user_answers"] = {
            type = "SELECT",
            table = "omik_polititablet_ansogninger",
            fields = {
                id = "id",
                formID = "formID",
                officer_id = "officer_id",
                structure = "structure",
                date = "date"
            },
            where = "officer_id = @officer_id"
        },
        ["/applications_user_answer_update"] = {
            type = "UPDATE",
            table = "omik_polititablet_ansogninger",
            update_fields = {"structure = @structure"},
            where = "id = @id"
        }
    }
}

queries.config = {
    esx = {
        ["/config_get"] = {
            type = "SELECT",
            table = "omik_polititablet_config LIMIT 0,1;",
            fields = {
                config = "config"
            }
        },
        ["/config_update"] = {
            type = "UPDATE",
            table = "omik_polititablet_config",
            update_fields = {"config = @config"}
        }
    },
    vrp = {
        ["/config_get"] = {
            type = "SELECT",
            table = "omik_polititablet_config LIMIT 0,1;",
            fields = {
                config = "config"
            }
        },
        ["/config_update"] = {
            type = "UPDATE",
            table = "omik_polititablet_config",
            update_fields = {"config = @config"}
        }
    },
    qbcore = {
        ["/config_get"] = {
            type = "SELECT",
            table = "omik_polititablet_config LIMIT 0,1;",
            fields = {
                config = "config"
            }
        },
        ["/config_update"] = {
            type = "UPDATE",
            table = "omik_polititablet_config",
            update_fields = {"config = @config"}
        }
    }
}

queries.employees = {
    esx = {
        ["/employees"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_ansatte an",
            fields = {
                ["an.rank"] = "rank",
                ["an.officer_id"] = "officer_id",
                ["an.profile_logo"] = "profile_logo",
                ["u.firstname"] = "firstname",
                ["u.lastname"] = "lastname",
                ["an.badge_number"] = "badge_number",
                ["an.responsible_area"] = "responsible_area",
                ["an.fleetStatus"] = "fleetStatus",
                ["an.on_duty"] = "on_duty"
            },
            joins = {"LEFT JOIN users u ON an.officer_id = u.officer_id"}
        },
        ["/users"] = {
            type = "SELECT",
            table = "users u",
            fields = {
                ["u.profile_logo"] = "profile_logo",
                ["u.firstname"] = "firstname",
                ["u.lastname"] = "lastname",
                ["u.dateofbirth"] = "dateofbirth",
                ["u.sex"] = "sex",
                ["u.phone_number"] = "phone_number",
                ["u.identifier"] = "identifier"
            },
            where = "CONCAT(u.firstname, ' ', u.lastname) LIKE @search",
            extra = "LIMIT 0,30"
        },
        ["/ranks"] = {
            type = "SELECT",
            table = "omik_polititablet_ansatte an",
            fields = {
                ["an.rank"] = "rank",
                ["an.responsible_area"] = "responsible_area",
                ["an.educations"] = "educations",
                ["an.certificates"] = "certificates"
            }
        },
        ["/create"] = {
            type = "INSERT",
            table = "omik_polititablet_ansatte",
            table_cols = "(officer_id, badge_number, password, on_duty, rank, responsible_area, profile_logo, employment_date, certificates, educations, permissions)",
            insert_fields = "(NULL, @badge_number, PASSWORD(@password), 0, @rank, @responsible_area, @profile_logo, NULL, @certificates, @educations, @permissions)"
        },
        ["/create_update_officer_id"] = {
            type = "UPDATE",
            table = "users",
            update_fields = {"officer_id = @officer_id"},
            where = "identifier = @identifier"
        },
        ["/delete"] = {
            type = "DELETE",
            table = "omik_polititablet_ansatte",
            where = "officer_id = @officer_id"
        },
        ["/delete_update_officer_id"] = {
            type = "UPDATE",
            table = "users",
            update_fields = {"officer_id = NULL"},
            where = "officer_id = @officer_id"
        },
        ["/edit"] = {
            type = "UPDATE",
            table = "omik_polititablet_ansatte",
            update_fields = {
                "badge_number = @badge_number",
                "rank = @rank",
                "responsible_area = @responsible_area",
                "certificates = @certificates",
                "educations = @educations",
                "permissions = @permissions"
            },
            where = "officer_id = @officer_id"
        },
        ["/latest"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_ansatte an",
            fields = {
                ["an.officer_id"] = "officer_id",
                ["u.firstname"] = "firstname",
                ["u.lastname"] = "lastname",
                ["an.badge_number"] = "badge_number",
                ["an.profile_logo"] = "profile_logo"
            },
            joins = {"LEFT JOIN users u ON an.officer_id = u.officer_id"},
            extra = "ORDER BY an.officer_id DESC LIMIT 3"
        }
    },
    vrp = {
        ["/employees"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_ansatte an",
            fields = {
                ["an.rank"] = "rank",
                ["an.officer_id"] = "officer_id",
                ["an.profile_logo"] = "profile_logo",
                ["u.firstname"] = "firstname",
                ["u.name"] = "lastname",
                ["an.badge_number"] = "badge_number",
                ["an.responsible_area"] = "responsible_area",
                ["an.fleetStatus"] = "fleetStatus",
                ["an.on_duty"] = "on_duty"
            },
            joins = {"LEFT JOIN vrp_user_identities u ON an.officer_id = u.officer_id"}
        },
        ["/users"] = {
            type = "SELECT",
            table = "vrp_user_identities u",
            fields = {
                ["u.profile_logo"] = "profile_logo",
                ["u.firstname"] = "firstname",
                ["u.name"] = "lastname",
                ["DATE_FORMAT(CURRENT_DATE() - INTERVAL u.age YEAR, '%d-%m-%Y')"] = "dateofbirth",
                ["u.phone"] = "phone_number",
                ["u.user_id"] = "identifier"
            },
            where = "CONCAT(u.firstname, ' ', u.name) LIKE @search",
            extra = "LIMIT 0,30"
        },
        ["/ranks"] = {
            type = "SELECT",
            table = "omik_polititablet_ansatte an",
            fields = {
                ["an.rank"] = "rank",
                ["an.responsible_area"] = "responsible_area",
                ["an.educations"] = "educations",
                ["an.certificates"] = "certificates"
            }
        },
        ["/create"] = {
            type = "INSERT",
            table = "omik_polititablet_ansatte",
            table_cols = "(officer_id, badge_number, password, on_duty, rank, responsible_area, profile_logo, employment_date, certificates, educations, permissions)",
            insert_fields = "(NULL, @badge_number, PASSWORD(@password), 0, @rank, @responsible_area, @profile_logo, NULL, @certificates, @educations, @permissions)"
        },
        ["/create_update_officer_id"] = {
            type = "UPDATE",
            table = "vrp_user_identities",
            update_fields = {"officer_id = @officer_id"},
            where = "user_id = @identifier"
        },
        ["/delete"] = {
            type = "DELETE",
            table = "omik_polititablet_ansatte",
            where = "officer_id = @officer_id"
        },
        ["/delete_update_officer_id"] = {
            type = "UPDATE",
            table = "vrp_user_identities",
            update_fields = {"officer_id = NULL"},
            where = "officer_id = @officer_id"
        },
        ["/edit"] = {
            type = "UPDATE",
            table = "omik_polititablet_ansatte",
            update_fields = {
                "badge_number = @badge_number",
                "rank = @rank",
                "responsible_area = @responsible_area",
                "certificates = @certificates",
                "educations = @educations",
                "permissions = @permissions"
            },
            where = "officer_id = @officer_id"
        },
        ["/latest"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_ansatte an",
            fields = {
                ["an.officer_id"] = "officer_id",
                ["u.firstname"] = "firstname",
                ["u.name"] = "lastname",
                ["an.badge_number"] = "badge_number",
                ["an.profile_logo"] = "profile_logo"
            },
            joins = {"LEFT JOIN vrp_user_identities u ON an.officer_id = u.officer_id"},
            extra = "ORDER BY an.officer_id DESC LIMIT 3"
        }
    },
    qbcore = {
        ["/employees"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_ansatte an",
            fields = {
                ["an.rank"] = "rank",
                ["an.officer_id"] = "officer_id",
                ["an.profile_logo"] = "profile_logo",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname'))"] = "firstname",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname'))"] = "lastname",
                ["an.badge_number"] = "badge_number",
                ["an.responsible_area"] = "responsible_area",
                ["an.fleetStatus"] = "fleetStatus",
                ["an.on_duty"] = "on_duty"
            },
            joins = {"LEFT JOIN players u ON an.officer_id = u.officer_id"}
        },
        ["/users"] = {
            type = "SELECT",
            table = "players u",
            fields = {
                ["u.profile_logo"] = "profile_logo",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname'))"] = "firstname",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname'))"] = "lastname",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.birthdate'))"] = "dateofbirth",
                ["JSON_EXTRACT(u.charinfo, '$.gender')"] = "sex",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.phone'))"] = "phone_number",
                ["u.citizenid"] = "identifier"
            },
            where = "CONCAT(JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname'))) LIKE @search",
            extra = "LIMIT 0,30"
        },
        ["/ranks"] = {
            type = "SELECT",
            table = "omik_polititablet_ansatte an",
            fields = {
                ["an.rank"] = "rank",
                ["an.responsible_area"] = "responsible_area",
                ["an.educations"] = "educations",
                ["an.certificates"] = "certificates"
            }
        },
        ["/create"] = {
            type = "INSERT",
            table = "omik_polititablet_ansatte",
            table_cols = "(officer_id, badge_number, password, on_duty, rank, responsible_area, profile_logo, employment_date, certificates, educations, permissions)",
            insert_fields = "(NULL, @badge_number, PASSWORD(@password), 0, @rank, @responsible_area, @profile_logo, NULL, @certificates, @educations, @permissions)"
        },
        ["/create_update_officer_id"] = {
            type = "UPDATE",
            table = "players",
            update_fields = {"officer_id = @officer_id"},
            where = "citizenid = @identifier"
        },
        ["/delete"] = {
            type = "DELETE",
            table = "omik_polititablet_ansatte",
            where = "officer_id = @officer_id"
        },
        ["/delete_update_officer_id"] = {
            type = "UPDATE",
            table = "players",
            update_fields = {"officer_id = NULL"},
            where = "officer_id = @officer_id"
        },
        ["/edit"] = {
            type = "UPDATE",
            table = "omik_polititablet_ansatte",
            update_fields = {
                "badge_number = @badge_number",
                "rank = @rank",
                "responsible_area = @responsible_area",
                "certificates = @certificates",
                "educations = @educations",
                "permissions = @permissions"
            },
            where = "officer_id = @officer_id"
        },
        ["/latest"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_ansatte an",
            fields = {
                ["an.officer_id"] = "officer_id",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname'))"] = "firstname",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname'))"] = "lastname",
                ["an.badge_number"] = "badge_number",
                ["an.profile_logo"] = "profile_logo"
            },
            joins = {"LEFT JOIN players u ON an.officer_id = u.officer_id"},
            extra = "ORDER BY an.officer_id DESC LIMIT 3"
        }
    }
}

queries.information = {
    esx = {
        ["/daily_msg"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_information inf",
            fields = {
                ["inf.id"] = "id",
                ["inf.content"] = "content",
                ["an.profile_logo"] = "profile_logo",
                ["CONCAT(u.firstname, ' ', u.lastname)"] = "name",
                ["an.badge_number"] = "badge_number",
                ["an.rank"] = "rank"
            },
            joins = {
                "LEFT JOIN users u ON inf.officer_id = u.officer_id",
                "LEFT JOIN omik_polititablet_ansatte an ON inf.officer_id = an.officer_id"
            },
            where = "daily_msg = 1",
            extra = "LIMIT 1"
        },
        ["/daily_msg_save"] = {
            type = "UPDATE",
            table = "omik_polititablet_information",
            update_fields = {"content = @content", "officer_id = @officer_id"},
            where = "id = @id"
        },
        ["/daily_msg_delete"] = {
            type = "DELETE",
            table = "omik_polititablet_information",
            where = "id = @id"
        },
        ["/daily_msg_create"] = {
            type = "INSERT",
            table = "omik_polititablet_information",
            table_cols = "(id, officer_id, daily_msg, title, content, likes, dislikes, date)",
            insert_fields = "(NULL, @officer_id, 1, 'Dagens Besked', @content, '[]', '[]', NULL)"
        },
        ["/posts"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_information inf",
            fields = {
                ["inf.id"] = "id",
                ["an.profile_logo"] = "profile_logo",
                ["CONCAT(u.firstname, ' ', u.lastname)"] = "name",
                ["an.badge_number"] = "badge_number",
                ["inf.date"] = "date",
                ["inf.title"] = "title",
                ["inf.content"] = "content",
                ["inf.likes"] = "likes",
                ["inf.dislikes"] = "dislikes"
            },
            joins = {
                "LEFT JOIN omik_polititablet_ansatte an ON inf.officer_id = an.officer_id",
                "LEFT JOIN users u ON inf.officer_id = u.officer_id"
            },
            where = "daily_msg != 1",
            extra = "ORDER BY inf.id DESC"
        },
        ["/posts_edit_officers"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_ansatte an",
            fields = {
                ["CONCAT(u.firstname, ' ', u.lastname)"] = "name",
                ["an.officer_id"] = "officer_id",
                ["an.badge_number"] = "badge_number",
                ["an.profile_logo"] = "profile_logo"
            },
            joins = {"INNER JOIN users u ON u.officer_id = an.officer_id"}
        },
        ["/posts_likes"] = {
            type = "UPDATE",
            table = "omik_polititablet_information",
            update_fields = {"likes = @likes"},
            where = "id = @id"
        },
        ["/posts_dislikes"] = {
            type = "UPDATE",
            table = "omik_polititablet_information",
            update_fields = {"dislikes = @dislikes"},
            where = "id = @id"
        },
        ["/posts_create"] = {
            type = "INSERT",
            table = "omik_polititablet_information",
            table_cols = "(id, officer_id, daily_msg, title, content, likes, dislikes, date)",
            insert_fields = "(NULL, @officer_id, 0, @title, @content, '[]', '[]', NULL)"
        },
        ["/posts_delete"] = {
            type = "DELETE",
            table = "omik_polititablet_information",
            where = "id = @id"
        },
        ["/posts_save"] = {
            type = "UPDATE",
            table = "omik_polititablet_information",
            update_fields = {"title = @title", "content = @content"},
            where = "id = @id"
        },
        ["/guides"] = {
            type = "SELECT",
            table = "omik_polititablet_guides",
            fields = {
                id = "id",
                color = "color",
                title = "title",
                content = "content"
            }
        },
        ["/guides_view"] = {
            type = "SELECT",
            table = "omik_polititablet_guides",
            fields = {
                title = "title",
                content = "content"
            },
            where = "id = @id"
        },
        ["/guides_create"] = {
            type = "INSERT",
            table = "omik_polititablet_guides",
            table_cols = "(id, officer_id, color, title, content, date)",
            insert_fields = "(NULL, @officer_id, @color, @title, @content, NULL)"
        },
        ["/guides_save_saveColor"] = {
            type = "UPDATE",
            table = "omik_polititablet_guides",
            update_fields = {"color = @color"},
            where = "id = @id"
        },
        ["/guides_save_saveEdit"] = {
            type = "UPDATE",
            table = "omik_polititablet_guides",
            update_fields = {"title = @title", "content = @content"},
            where = "id = @id"
        },
        ["/guides_save_deleteGuide"] = {
            type = "DELETE",
            table = "omik_polititablet_guides",
            where = "id = @id"
        }
    },
    vrp = {
        ["/daily_msg"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_information inf",
            fields = {
                ["inf.id"] = "id",
                ["inf.content"] = "content",
                ["an.profile_logo"] = "profile_logo",
                ["CONCAT(u.firstname, ' ', u.name)"] = "name",
                ["an.badge_number"] = "badge_number",
                ["an.rank"] = "rank"
            },
            joins = {
                "LEFT JOIN vrp_user_identities u ON inf.officer_id = u.officer_id",
                "LEFT JOIN omik_polititablet_ansatte an ON inf.officer_id = an.officer_id"
            },
            where = "daily_msg = 1",
            extra = "LIMIT 1"
        },
        ["/daily_msg_save"] = {
            type = "UPDATE",
            table = "omik_polititablet_information",
            update_fields = {"content = @content", "officer_id = @officer_id"},
            where = "id = @id"
        },
        ["/daily_msg_delete"] = {
            type = "DELETE",
            table = "omik_polititablet_information",
            where = "id = @id"
        },
        ["/daily_msg_create"] = {
            type = "INSERT",
            table = "omik_polititablet_information",
            table_cols = "(id, officer_id, daily_msg, title, content, likes, dislikes, date)",
            insert_fields = "(NULL, @officer_id, 1, 'Dagens Besked', @content, '[]', '[]', NULL)"
        },
        ["/posts"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_information inf",
            fields = {
                ["inf.id"] = "id",
                ["an.profile_logo"] = "profile_logo",
                ["CONCAT(u.firstname, ' ', u.name)"] = "name",
                ["an.badge_number"] = "badge_number",
                ["inf.date"] = "date",
                ["inf.title"] = "title",
                ["inf.content"] = "content",
                ["inf.likes"] = "likes",
                ["inf.dislikes"] = "dislikes"
            },
            joins = {
                "LEFT JOIN omik_polititablet_ansatte an ON inf.officer_id = an.officer_id",
                "LEFT JOIN vrp_user_identities u ON inf.officer_id = u.officer_id"
            },
            where = "daily_msg != 1",
            extra = "ORDER BY inf.id DESC"
        },
        ["/posts_edit_officers"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_ansatte an",
            fields = {
                ["CONCAT(u.firstname, ' ', u.name)"] = "name",
                ["an.officer_id"] = "officer_id",
                ["an.badge_number"] = "badge_number",
                ["an.profile_logo"] = "profile_logo"
            },
            joins = {"INNER JOIN vrp_user_identities u ON u.officer_id = an.officer_id"}
        },
        ["/posts_likes"] = {
            type = "UPDATE",
            table = "omik_polititablet_information",
            update_fields = {"likes = @likes"},
            where = "id = @id"
        },
        ["/posts_dislikes"] = {
            type = "UPDATE",
            table = "omik_polititablet_information",
            update_fields = {"dislikes = @dislikes"},
            where = "id = @id"
        },
        ["/posts_create"] = {
            type = "INSERT",
            table = "omik_polititablet_information",
            table_cols = "(id, officer_id, daily_msg, title, content, likes, dislikes, date)",
            insert_fields = "(NULL, @officer_id, 0, @title, @content, '[]', '[]', NULL)"
        },
        ["/posts_delete"] = {
            type = "DELETE",
            table = "omik_polititablet_information",
            where = "id = @id"
        },
        ["/posts_save"] = {
            type = "UPDATE",
            table = "omik_polititablet_information",
            update_fields = {"title = @title", "content = @content"},
            where = "id = @id"
        },
        ["/guides"] = {
            type = "SELECT",
            table = "omik_polititablet_guides",
            fields = {
                id = "id",
                color = "color",
                title = "title",
                content = "content"
            }
        },
        ["/guides_view"] = {
            type = "SELECT",
            table = "omik_polititablet_guides",
            fields = {
                title = "title",
                content = "content"
            },
            where = "id = @id"
        },
        ["/guides_create"] = {
            type = "INSERT",
            table = "omik_polititablet_guides",
            table_cols = "(id, officer_id, color, title, content, date)",
            insert_fields = "(NULL, @officer_id, @color, @title, @content, NULL)"
        },
        ["/guides_save_saveColor"] = {
            type = "UPDATE",
            table = "omik_polititablet_guides",
            update_fields = {"color = @color"},
            where = "id = @id"
        },
        ["/guides_save_saveEdit"] = {
            type = "UPDATE",
            table = "omik_polititablet_guides",
            update_fields = {"title = @title", "content = @content"},
            where = "id = @id"
        },
        ["/guides_save_deleteGuide"] = {
            type = "DELETE",
            table = "omik_polititablet_guides",
            where = "id = @id"
        }
    },
    qbcore = {
        ["/daily_msg"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_information inf",
            fields = {
                ["inf.id"] = "id",
                ["inf.content"] = "content",
                ["an.profile_logo"] = "profile_logo",
                ["CONCAT(JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname')))"] = "name",
                ["an.badge_number"] = "badge_number",
                ["an.rank"] = "rank"
            },
            joins = {
                "LEFT JOIN players u ON inf.officer_id = u.officer_id",
                "LEFT JOIN omik_polititablet_ansatte an ON inf.officer_id = an.officer_id"
            },
            where = "daily_msg = 1",
            extra = "LIMIT 1"
        },
        ["/daily_msg_save"] = {
            type = "UPDATE",
            table = "omik_polititablet_information",
            update_fields = {"content = @content", "officer_id = @officer_id"},
            where = "id = @id"
        },
        ["/daily_msg_delete"] = {
            type = "DELETE",
            table = "omik_polititablet_information",
            where = "id = @id"
        },
        ["/daily_msg_create"] = {
            type = "INSERT",
            table = "omik_polititablet_information",
            table_cols = "(id, officer_id, daily_msg, title, content, likes, dislikes, date)",
            insert_fields = "(NULL, @officer_id, 1, 'Dagens Besked', @content, '[]', '[]', NULL)"
        },
        ["/posts"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_information inf",
            fields = {
                ["inf.id"] = "id",
                ["an.profile_logo"] = "profile_logo",
                ["CONCAT(JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname')))"] = "name",
                ["an.badge_number"] = "badge_number",
                ["inf.date"] = "date",
                ["inf.title"] = "title",
                ["inf.content"] = "content",
                ["inf.likes"] = "likes",
                ["inf.dislikes"] = "dislikes"
            },
            joins = {
                "LEFT JOIN omik_polititablet_ansatte an ON inf.officer_id = an.officer_id",
                "LEFT JOIN players u ON inf.officer_id = u.officer_id"
            },
            where = "daily_msg != 1",
            extra = "ORDER BY inf.id DESC"
        },
        ["/posts_edit_officers"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_ansatte an",
            fields = {
                ["CONCAT(JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname')))"] = "name",
                ["an.officer_id"] = "officer_id",
                ["an.badge_number"] = "badge_number",
                ["an.profile_logo"] = "profile_logo"
            },
            joins = {"INNER JOIN players u ON u.officer_id = an.officer_id"}
        },
        ["/posts_likes"] = {
            type = "UPDATE",
            table = "omik_polititablet_information",
            update_fields = {"likes = @likes"},
            where = "id = @id"
        },
        ["/posts_dislikes"] = {
            type = "UPDATE",
            table = "omik_polititablet_information",
            update_fields = {"dislikes = @dislikes"},
            where = "id = @id"
        },
        ["/posts_create"] = {
            type = "INSERT",
            table = "omik_polititablet_information",
            table_cols = "(id, officer_id, daily_msg, title, content, likes, dislikes, date)",
            insert_fields = "(NULL, @officer_id, 0, @title, @content, '[]', '[]', NULL)"
        },
        ["/posts_delete"] = {
            type = "DELETE",
            table = "omik_polititablet_information",
            where = "id = @id"
        },
        ["/posts_save"] = {
            type = "UPDATE",
            table = "omik_polititablet_information",
            update_fields = {"title = @title", "content = @content"},
            where = "id = @id"
        },
        ["/guides"] = {
            type = "SELECT",
            table = "omik_polititablet_guides",
            fields = {
                id = "id",
                color = "color",
                title = "title",
                content = "content"
            }
        },
        ["/guides_view"] = {
            type = "SELECT",
            table = "omik_polititablet_guides",
            fields = {
                title = "title",
                content = "content"
            },
            where = "id = @id"
        },
        ["/guides_create"] = {
            type = "INSERT",
            table = "omik_polititablet_guides",
            table_cols = "(id, officer_id, color, title, content, date)",
            insert_fields = "(NULL, @officer_id, @color, @title, @content, NULL)"
        },
        ["/guides_save_saveColor"] = {
            type = "UPDATE",
            table = "omik_polititablet_guides",
            update_fields = {"color = @color"},
            where = "id = @id"
        },
        ["/guides_save_saveEdit"] = {
            type = "UPDATE",
            table = "omik_polititablet_guides",
            update_fields = {"title = @title", "content = @content"},
            where = "id = @id"
        },
        ["/guides_save_deleteGuide"] = {
            type = "DELETE",
            table = "omik_polititablet_guides",
            where = "id = @id"
        }
    }
}

queries.laws = {
    esx = {
        ["/"] = {
            type = "SELECT",
            table = "omik_polititablet_laws",
            fields = {
                type = "type",
                id = "id",
                law = "law",
                paragraph = "paragraph",
                title = "title",
                cols = "cols"
            }
        },
        ["/update"] = {
            type = "UPDATE",
            table = "omik_polititablet_laws",
            update_fields = {"paragraph = @paragraph", "title = @title", "cols = @cols"},
            where = "id = @id"
        },
        ["/create"] = {
            type = "INSERT",
            table = "omik_polititablet_laws",
            table_cols = "(id, type, law, paragraph, title, cols)",
            insert_fields = "(NULL, @type, @law, @paragraph, @title, @cols)"
        },
        ["/delete"] = {
            type = "DELETE",
            table = "omik_polititablet_laws",
            where = "law LIKE @law"
        },
        ["/law_delete"] = {
            type = "DELETE",
            table = "omik_polititablet_laws",
            where = "id = @id"
        }
    },
    vrp = {
        ["/"] = {
            type = "SELECT",
            table = "omik_polititablet_laws",
            fields = {
                type = "type",
                id = "id",
                law = "law",
                paragraph = "paragraph",
                title = "title",
                cols = "cols"
            }
        },
        ["/update"] = {
            type = "UPDATE",
            table = "omik_polititablet_laws",
            update_fields = {"paragraph = @paragraph", "title = @title", "cols = @cols"},
            where = "id = @id"
        },
        ["/create"] = {
            type = "INSERT",
            table = "omik_polititablet_laws",
            table_cols = "(id, type, law, paragraph, title, cols)",
            insert_fields = "(NULL, @type, @law, @paragraph, @title, @cols)"
        },
        ["/delete"] = {
            type = "DELETE",
            table = "omik_polititablet_laws",
            where = "law LIKE @law"
        },
        ["/law_delete"] = {
            type = "DELETE",
            table = "omik_polititablet_laws",
            where = "id = @id"
        }
    },
    qbcore = {
        ["/"] = {
            type = "SELECT",
            table = "omik_polititablet_laws",
            fields = {
                type = "type",
                id = "id",
                law = "law",
                paragraph = "paragraph",
                title = "title",
                cols = "cols"
            }
        },
        ["/update"] = {
            type = "UPDATE",
            table = "omik_polititablet_laws",
            update_fields = {"paragraph = @paragraph", "title = @title", "cols = @cols"},
            where = "id = @id"
        },
        ["/create"] = {
            type = "INSERT",
            table = "omik_polititablet_laws",
            table_cols = "(id, type, law, paragraph, title, cols)",
            insert_fields = "(NULL, @type, @law, @paragraph, @title, @cols)"
        },
        ["/delete"] = {
            type = "DELETE",
            table = "omik_polititablet_laws",
            where = "law LIKE @law"
        },
        ["/law_delete"] = {
            type = "DELETE",
            table = "omik_polititablet_laws",
            where = "id = @id"
        }
    }
}

queries.logs = {
    esx = {
        ["/logs_get"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_logs logs",
            fields = {
                ["logs.id"] = "id",
                ["logs.officer_id"] = "officer_id",
                ["logs.action"] = "action",
                ["logs.title"] = "title",
                ["logs.description"] = "description",
                ["logs.date"] = "date",
                ["an.badge_number"] = "badge_number",
                ["an.rank"] = "rank",
                ["an.profile_logo"] = "profile_logo",
                ["CONCAT(u.firstname, ' ', u.lastname)"] = "name"
            },
            joins = {
                "LEFT JOIN omik_polititablet_ansatte an ON an.officer_id = logs.officer_id",
                "LEFT JOIN users u ON u.officer_id = logs.officer_id"
            },
            extra = "ORDER BY date DESC LIMIT 50"
        },
        ["/logs_create"] = {
            type = "INSERT",
            table = "omik_polititablet_logs",
            table_cols = "(id, officer_id, action, title, description, date)",
            insert_fields = "(NULL, @officer_id, @action, @title, @description, CURRENT_TIMESTAMP())"
        }
    },
    vrp = {
        ["/logs_get"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_logs logs",
            fields = {
                ["logs.id"] = "id",
                ["logs.officer_id"] = "officer_id",
                ["logs.action"] = "action",
                ["logs.title"] = "title",
                ["logs.description"] = "description",
                ["logs.date"] = "date",
                ["an.badge_number"] = "badge_number",
                ["an.rank"] = "rank",
                ["an.profile_logo"] = "profile_logo",
                ["CONCAT(u.firstname, ' ', u.name)"] = "name"
            },
            joins = {
                "LEFT JOIN omik_polititablet_ansatte an ON an.officer_id = logs.officer_id",
                "LEFT JOIN vrp_user_identities u ON u.officer_id = logs.officer_id"
            },
            extra = "ORDER BY date DESC LIMIT 50"
        },
        ["/logs_create"] = {
            type = "INSERT",
            table = "omik_polititablet_logs",
            table_cols = "(id, officer_id, action, title, description, date)",
            insert_fields = "(NULL, @officer_id, @action, @title, @description, CURRENT_TIMESTAMP())"
        }
    },
    qbcore = {
        ["/logs_get"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_logs logs",
            fields = {
                ["logs.id"] = "id",
                ["logs.officer_id"] = "officer_id",
                ["logs.action"] = "action",
                ["logs.title"] = "title",
                ["logs.description"] = "description",
                ["logs.date"] = "date",
                ["an.badge_number"] = "badge_number",
                ["an.rank"] = "rank",
                ["an.profile_logo"] = "profile_logo",
                ["CONCAT(JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname')))"] = "name"
            },
            joins = {
                "LEFT JOIN omik_polititablet_ansatte an ON an.officer_id = logs.officer_id",
                "LEFT JOIN players u ON u.officer_id = logs.officer_id"
            },
            extra = "ORDER BY date DESC LIMIT 50"
        },
        ["/logs_create"] = {
            type = "INSERT",
            table = "omik_polititablet_logs",
            table_cols = "(id, officer_id, action, title, description, date)",
            insert_fields = "(NULL, @officer_id, @action, @title, @description, CURRENT_TIMESTAMP())"
        }
    }
}

queries.offenses = {
    esx = {
        ["/delete_offense"] = {
            type = "DELETE",
            table = "omik_polititablet_sigtelser",
            where = "offense_id = @offense_id"
        },
        ["/create_offense"] = {
            type = "INSERT",
            table = "omik_polititablet_sigtelser",
            table_cols = "(offense_id, identifier, officer_id, date, officers, offenses, confiscated, lawyer, weapons_used, total_offense_amount, report)",
            insert_fields = "(NULL, @identifier, @officer_id, CURRENT_TIMESTAMP(), @officers, @offenses, @confiscated, @lawyer, @weapons_used, @total_offense_amount, @report)"
        },
        ["/edit_offense"] = {
            type = "UPDATE",
            table = "omik_polititablet_sigtelser sig",
            update_fields = {
                "sig.officers = @officers, sig.offenses = @offenses, sig.confiscated = @confiscated, sig.lawyer = @lawyer, sig.weapons_used = @weapons_used, sig.total_offense_amount = @total_offense_amount, sig.report = @report"
            },
            where = "sig.offense_id = @offenses_id"
        },
        ["/create_offense_warrant"] = {
            type = "INSERT",
            table = "omik_polititablet_frakendelser",
            table_cols = "(id, identifier, expires)",
            insert_fields = "(NULL, @identifier, CURRENT_DATE() + INTERVAL @expires DAY)"
        },
        ["/search_offense"] = {
            type = "SELECT_JOIN",
            table = "users u",
            fields = {
                ["u.identifier"] = "identifier",
                ["u.profile_logo"] = "profile_logo",
                ["u.firstname"] = "firstname",
                ["u.lastname"] = "lastname",
                ["u.dateofbirth"] = "dateofbirth",
                ["u.sex"] = "sex",
                ["u.phone_number"] = "phone_number",
                ["group_concat(DISTINCT CONCAT(' ', IFNULL(op.name, 'Ingen Adresse')))"] = "address",
                ["IFNULL(oe.type, 'no_warrant')"] = "warrant",
                ["IFNULL(of.expires, 'no_disq')"] = "disq"
            },
            joins = {
                "LEFT JOIN omik_polititablet_frakendelser of ON (of.identifier = u.identifier COLLATE utf8mb4_general_ci)",
                "LEFT JOIN omik_polititablet_efterlysninger oe ON (oe.identifier = u.identifier COLLATE utf8mb4_general_ci)",
                "LEFT JOIN owned_properties op ON (op.owner = u.identifier COLLATE utf8mb4_general_ci)"
            },
            where = "CONCAT(u.firstname, ' ', u.lastname) LIKE @name AND u.sex LIKE @sex",
            extra = "group by u.identifier LIMIT 0,30"
        },
        ["/search_offense_license"] = {
            type = "SELECT_JOIN",
            table = "users u",
            fields = {
                ["u.identifier"] = "identifier",
                ["u.profile_logo"] = "profile_logo",
                ["u.firstname"] = "firstname",
                ["u.lastname"] = "lastname",
                ["u.dateofbirth"] = "dateofbirth",
                ["u.sex"] = "sex",
                ["u.phone_number"] = "phone_number",
                ["group_concat(DISTINCT CONCAT(' ', IFNULL(op.name, 'Ingen Adresse')))"] = "address",
                ["IFNULL(oe.type, 'no_warrant')"] = "warrant",
                ["IFNULL(of.expires, 'no_disq')"] = "disq",
                ["IFNULL(group_concat(DISTINCT IF(ul.type LIKE 'drive', ul.type, NULL)), 'no_drive')"] = "license"
            },
            joins = {
                "LEFT JOIN omik_polititablet_frakendelser of ON (of.identifier = u.identifier COLLATE utf8mb4_general_ci)",
                "LEFT JOIN omik_polititablet_efterlysninger oe ON (oe.identifier = u.identifier COLLATE utf8mb4_general_ci)",
                "LEFT JOIN user_licenses ul ON (ul.owner = u.identifier COLLATE utf8mb4_general_ci)",
                "LEFT JOIN owned_properties op ON (op.owner = u.identifier COLLATE utf8mb4_general_ci)"
            },
            where = "CONCAT(u.firstname, ' ', u.lastname) LIKE @name AND u.sex LIKE @sex",
            extra = "group by u.identifier LIMIT 0,30"
        },
        ["/user"] = {
            type = "SELECT_JOIN",
            table = "users u",
            fields = {
                ["u.profile_logo"] = "profile_logo",
                ["u.firstname"] = "firstname",
                ["u.lastname"] = "lastname",
                ["u.dateofbirth"] = "dateofbirth",
                ["u.phone_number"] = "phone_number",
                ["u.tablet_notes"] = "tablet_notes",
                ["jb.label"] = "label",
                ["IFNULL(oe.type, 'no_warrant')"] = "warrant",
                ["IFNULL(of.expires, 'no_disq')"] = "disq",
                ["u.identifier"] = "identifier",
                ["u.sex"] = "sex",
                ["group_concat(DISTINCT CONCAT(' ', IFNULL(op.name, 'Ingen Adresse')))"] = "address"
            },
            joins = {
                "LEFT JOIN jobs jb ON (jb.name = u.job COLLATE utf8mb4_general_ci)",
                "LEFT JOIN omik_polititablet_frakendelser of ON (of.identifier = u.identifier COLLATE utf8mb4_general_ci)",
                "LEFT JOIN omik_polititablet_efterlysninger oe ON (oe.identifier = u.identifier COLLATE utf8mb4_general_ci)",
                "LEFT JOIN owned_properties op ON (op.owner = u.identifier COLLATE utf8mb4_general_ci)"
            },
            where = "u.identifier = @identifier",
            extra = "group by u.identifier"
        },
        ["/user_license"] = {
            type = "SELECT_JOIN",
            table = "users u",
            fields = {
                ["u.profile_logo"] = "profile_logo",
                ["u.firstname"] = "firstname",
                ["u.lastname"] = "lastname",
                ["u.dateofbirth"] = "dateofbirth",
                ["u.phone_number"] = "phone_number",
                ["u.tablet_notes"] = "tablet_notes",
                ["jb.label"] = "label",
                ["IFNULL(oe.type, 'no_warrant')"] = "warrant",
                ["IFNULL(of.expires, 'no_disq')"] = "disq",
                ["u.identifier"] = "identifier",
                ["u.sex"] = "sex",
                ["group_concat(DISTINCT CONCAT(' ', IFNULL(op.name, 'Ingen Adresse')))"] = "address",
                ["IFNULL(group_concat(DISTINCT IF(ul.type LIKE 'drive', ul.type, NULL)), 'no_drive')"] = "license"
            },
            joins = {
                "LEFT JOIN jobs jb ON (jb.name = u.job COLLATE utf8mb4_general_ci)",
                "LEFT JOIN user_licenses ul ON (ul.owner = u.identifier COLLATE utf8mb4_general_ci)",
                "LEFT JOIN omik_polititablet_frakendelser of ON (of.identifier = u.identifier COLLATE utf8mb4_general_ci)",
                "LEFT JOIN omik_polititablet_efterlysninger oe ON (oe.identifier = u.identifier COLLATE utf8mb4_general_ci)",
                "LEFT JOIN owned_properties op ON (op.owner = u.identifier COLLATE utf8mb4_general_ci)"
            },
            where = "u.identifier = @identifier",
            extra = "group by u.identifier"
        },
        ["/user_offenses"] = {
            type = "SELECT",
            table = "omik_polititablet_sigtelser sig",
            fields = {
                ["sig.offense_id"] = "offense_id",
                ["sig.officer_id"] = "officer_id",
                ["sig.date"] = "date",
                ["sig.lawyer"] = "lawyer",
                ["sig.total_offense_amount"] = "total_offense_amount",
                ["sig.officers"] = "officers",
                ["sig.weapons_used"] = "weapons_used",
                ["sig.offenses"] = "offenses",
                ["sig.confiscated"] = "confiscated",
                ["sig.report"] = "report"
            },
            where = "identifier = @identifier"
        },
        ["/user_offenses_officers"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_ansatte an",
            fields = {
                ["CONCAT(u.firstname, ' ', u.lastname)"] = "name",
                ["an.officer_id"] = "officer_id",
                ["an.badge_number"] = "badge_number",
                ["an.profile_logo"] = "profile_logo",
                ["an.rank"] = "rank"
            },
            joins = {"INNER JOIN users u ON u.officer_id = an.officer_id"}
        },
        ["/user_properties_check_table_owned_properties"] = {
            type = "SHOW",
            table = "owned_properties"
        },
        ["/user_properties_check_table_properties"] = {
            type = "SHOW",
            table = "properties"
        },
        ["/user_properties"] = {
            type = "SELECT_JOIN",
            table = "owned_properties op",
            fields = {
                ["op.name"] = "name",
                ["op.price"] = "price",
                ["op.rented"] = "rented",
                ["op.owner"] = "owner",
                ["p.entering"] = "entering"
            },
            joins = {"INNER JOIN properties p ON (p.name = op.name COLLATE utf8mb4_general_ci)"},
            where = "op.owner = @identifier"
        },
        ["/user_vehicles"] = {
            type = "SELECT_JOIN",
            table = "owned_vehicles ov",
            fields = {
                ["ov.plate"] = "plate",
                ["ov.vehicle"] = "vehicle",
                ["ov.type"] = "type",
                ["ov.owner"] = "owner",
                ["ov.thumbnail"] = "thumbnail",
                ["IFNULL(oe.type, 'no_warrant')"] = "warrant"
            },
            joins = {
                "LEFT JOIN omik_polititablet_efterlysninger oe ON (oe.plate = ov.plate COLLATE utf8mb4_general_ci)"
            },
            where = "ov.owner = @identifier"
        },
        ["/user_logo"] = {
            type = "UPDATE",
            table = "users u",
            update_fields = {"u.profile_logo = @profile_logo"},
            where = "u.identifier = @identifier"
        },
        ["/user/notes"] = {
            type = "UPDATE",
            table = "users u",
            update_fields = {"u.tablet_notes = @tablet_notes"},
            where = "u.identifier = @identifier"
        },
        ["/latest"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_sigtelser sig",
            fields = {
                ["sig.offense_id"] = "offense_id",
                ["sig.identifier"] = "identifier",
                ["u.firstname"] = "firstname",
                ["u.lastname"] = "lastname",
                ["u.profile_logo"] = "user_profile_logo",
                ["an.profile_logo"] = "officer_profile_logo",
                ["sig.date"] = "date",
                ["CONCAT(uo.firstname, ' ', uo.lastname)"] = "name",
                ["an.badge_number"] = "badge_number",
                ["sig.total_offense_amount"] = "total_offense_amount"
            },
            joins = {
                "LEFT JOIN users u ON sig.identifier = u.identifier",
                "LEFT JOIN users uo ON sig.officer_id = uo.officer_id",
                "LEFT JOIN omik_polititablet_ansatte an ON sig.officer_id = an.officer_id"
            },
            extra = "ORDER BY sig.offense_id DESC LIMIT 3"
        }
    },
    vrp = {
        ["/delete_offense"] = {
            type = "DELETE",
            table = "omik_polititablet_sigtelser",
            where = "offense_id = @offense_id"
        },
        ["/create_offense"] = {
            type = "INSERT",
            table = "omik_polititablet_sigtelser",
            table_cols = "(offense_id, identifier, officer_id, date, officers, offenses, confiscated, lawyer, weapons_used, total_offense_amount, report)",
            insert_fields = "(NULL, @identifier, @officer_id, CURRENT_TIMESTAMP(), @officers, @offenses, @confiscated, @lawyer, @weapons_used, @total_offense_amount, @report)"
        },
        ["/edit_offense"] = {
            type = "UPDATE",
            table = "omik_polititablet_sigtelser sig",
            update_fields = {
                "sig.officers = @officers, sig.offenses = @offenses, sig.confiscated = @confiscated, sig.lawyer = @lawyer, sig.weapons_used = @weapons_used, sig.total_offense_amount = @total_offense_amount, sig.report = @report"
            },
            where = "sig.offense_id = @offense_id"
        },
        ["/create_offense_warrant"] = {
            type = "INSERT",
            table = "omik_polititablet_frakendelser",
            table_cols = "(id, identifier, expires)",
            insert_fields = "(NULL, @identifier, CURRENT_DATE() + INTERVAL @expires DAY)"
        },
        ["/search_offense"] = {
            type = "SELECT_JOIN",
            table = "vrp_user_identities u",
            fields = {
                ["u.user_id"] = "identifier",
                ["u.profile_logo"] = "profile_logo",
                ["u.firstname"] = "firstname",
                ["u.name"] = "lastname",
                ["DATE_FORMAT(CURRENT_DATE() - INTERVAL u.age YEAR, '%d-%m-%Y')"] = "dateofbirth",
                ["u.phone"] = "phone_number",
                ["group_concat(DISTINCT CONCAT(' ', IFNULL(op.home, 'Ingen Adresse')))"] = "address",
                ["IFNULL(oe.type, 'no_warrant')"] = "warrant",
                ["IFNULL(of.expires, 'no_disq')"] = "disq"
            },
            joins = {
                "LEFT JOIN omik_polititablet_frakendelser of ON of.identifier = u.user_id",
                "LEFT JOIN omik_polititablet_efterlysninger oe ON oe.identifier = u.user_id",
                "LEFT JOIN vrp_users us ON us.id = u.user_id",
                "LEFT JOIN vrp_user_homes op ON op.user_id = u.user_id"
            },
            where = "CONCAT(u.firstname, ' ', u.name) LIKE @name",
            extra = "group by u.user_id LIMIT 0,30"
        },
        ["/search_offense_license"] = {
            type = "SELECT_JOIN",
            table = "vrp_user_identities u",
            fields = {
                ["u.user_id"] = "identifier",
                ["u.profile_logo"] = "profile_logo",
                ["u.firstname"] = "firstname",
                ["u.name"] = "lastname",
                ["DATE_FORMAT(CURRENT_DATE() - INTERVAL u.age YEAR, '%d-%m-%Y')"] = "dateofbirth",
                ["u.phone"] = "phone_number",
                ["group_concat(DISTINCT CONCAT(' ', IFNULL(op.home, 'Ingen Adresse')))"] = "address",
                ["IFNULL(oe.type, 'no_warrant')"] = "warrant",
                ["IFNULL(of.expires, 'no_disq')"] = "disq",
                ["IF(us.DmvTest=0,'no_drive','drive')"] = "license"
            },
            joins = {
                "LEFT JOIN omik_polititablet_frakendelser of ON of.identifier = u.user_id",
                "LEFT JOIN omik_polititablet_efterlysninger oe ON oe.identifier = u.user_id",
                "LEFT JOIN vrp_users us ON us.id = u.user_id",
                "LEFT JOIN vrp_user_homes op ON op.user_id = u.user_id"
            },
            where = "CONCAT(u.firstname, ' ', u.name) LIKE @name",
            extra = "group by u.user_id LIMIT 0,30"
        },
        ["/user"] = {
            type = "SELECT_JOIN",
            table = "vrp_user_identities u",
            fields = {
                ["u.profile_logo"] = "profile_logo",
                ["u.firstname"] = "firstname",
                ["u.name"] = "lastname",
                ["DATE_FORMAT(CURRENT_DATE() - INTERVAL u.age YEAR, '%d-%m-%Y')"] = "dateofbirth",
                ["u.phone"] = "phone_number",
                ["u.tablet_notes"] = "tablet_notes",
                ["IFNULL(oe.type, 'no_warrant')"] = "warrant",
                ["IFNULL(of.expires, 'no_disq')"] = "disq",
                ["u.user_id"] = "identifier",
                ["group_concat(DISTINCT CONCAT(' ', IFNULL(op.home, 'Ingen Adresse')))"] = "address"
            },
            joins = {
                "LEFT JOIN vrp_users us ON us.id = u.user_id",
                "LEFT JOIN omik_polititablet_frakendelser of ON of.identifier = u.user_id",
                "LEFT JOIN omik_polititablet_efterlysninger oe ON oe.identifier = u.user_id",
                "LEFT JOIN vrp_user_homes op ON op.user_id = u.user_id"
            },
            where = "u.user_id = @identifier",
            extra = "group by u.user_id"
        },
        ["/user_license"] = {
            type = "SELECT_JOIN",
            table = "vrp_user_identities u",
            fields = {
                ["u.profile_logo"] = "profile_logo",
                ["u.firstname"] = "firstname",
                ["u.name"] = "lastname",
                ["DATE_FORMAT(CURRENT_DATE() - INTERVAL u.age YEAR, '%d-%m-%Y')"] = "dateofbirth",
                ["u.phone"] = "phone_number",
                ["u.tablet_notes"] = "tablet_notes",
                ["IFNULL(oe.type, 'no_warrant')"] = "warrant",
                ["IFNULL(of.expires, 'no_disq')"] = "disq",
                ["u.user_id"] = "identifier",
                ["group_concat(DISTINCT CONCAT(' ', IFNULL(op.home, 'Ingen Adresse')))"] = "address",
                ["IF(us.DmvTest=0,'no_drive','drive')"] = "license"
            },
            joins = {
                "LEFT JOIN vrp_users us ON us.id = u.user_id",
                "LEFT JOIN omik_polititablet_frakendelser of ON of.identifier = u.user_id",
                "LEFT JOIN omik_polititablet_efterlysninger oe ON oe.identifier = u.user_id",
                "LEFT JOIN vrp_user_homes op ON op.user_id = u.user_id"
            },
            where = "u.user_id = @identifier",
            extra = "group by u.user_id"
        },
        ["/user_offenses"] = {
            type = "SELECT",
            table = "omik_polititablet_sigtelser sig",
            fields = {
                ["sig.offense_id"] = "offense_id",
                ["sig.officer_id"] = "officer_id",
                ["sig.date"] = "date",
                ["sig.lawyer"] = "lawyer",
                ["sig.total_offense_amount"] = "total_offense_amount",
                ["sig.officers"] = "officers",
                ["sig.weapons_used"] = "weapons_used",
                ["sig.offenses"] = "offenses",
                ["sig.confiscated"] = "confiscated",
                ["sig.report"] = "report"
            },
            where = "identifier = @identifier"
        },
        ["/user_offenses_officers"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_ansatte an",
            fields = {
                ["CONCAT(u.firstname, ' ', u.name)"] = "name",
                ["an.officer_id"] = "officer_id",
                ["an.badge_number"] = "badge_number",
                ["an.profile_logo"] = "profile_logo",
                ["an.rank"] = "rank"
            },
            joins = {"INNER JOIN vrp_user_identities u ON u.officer_id = an.officer_id"}
        },
        ["/user_properties"] = {
            type = "SELECT",
            table = "vrp_user_homes",
            fields = {
                home = "name",
                user_id = "owner",
                number = "number"
            },
            where = "user_id = @identifier"
        },
        ["/user_vehicles"] = {
            type = "SELECT_JOIN",
            table = "vrp_user_vehicles ov",
            fields = {
                ["ov.vehicle_plate"] = "plate",
                ["ov.vehicle"] = "vehicle_name",
                ["ov.veh_type"] = "type",
                ["ov.user_id"] = "owner",
                ["ov.thumbnail"] = "thumbnail",
                ["IFNULL(oe.type, 'no_warrant')"] = "warrant"
            },
            joins = {
                "LEFT JOIN omik_polititablet_efterlysninger oe ON (oe.plate = ov.vehicle_plate COLLATE utf8mb4_general_ci)"
            },
            where = "ov.user_id = @identifier"
        },
        ["/user_logo"] = {
            type = "UPDATE",
            table = "vrp_user_identities u",
            update_fields = {"u.profile_logo = @profile_logo"},
            where = "u.user_id = @identifier"
        },
        ["/user/notes"] = {
            type = "UPDATE",
            table = "vrp_user_identities u",
            update_fields = {"u.tablet_notes = @tablet_notes"},
            where = "u.user_id = @identifier"
        },
        ["/latest"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_sigtelser sig",
            fields = {
                ["sig.offense_id"] = "offense_id",
                ["sig.identifier"] = "identifier",
                ["u.firstname"] = "firstname",
                ["u.name"] = "lastname",
                ["u.profile_logo"] = "user_profile_logo",
                ["an.profile_logo"] = "officer_profile_logo",
                ["sig.date"] = "date",
                ["CONCAT(uo.firstname, ' ', uo.name)"] = "name",
                ["an.badge_number"] = "badge_number",
                ["sig.total_offense_amount"] = "total_offense_amount"
            },
            joins = {
                "LEFT JOIN vrp_user_identities u ON sig.identifier = u.user_id",
                "LEFT JOIN vrp_user_identities uo ON sig.officer_id = uo.officer_id",
                "LEFT JOIN omik_polititablet_ansatte an ON sig.officer_id = an.officer_id"
            },
            extra = "ORDER BY sig.offense_id DESC LIMIT 3"
        }
    },
    qbcore = {
        ["/delete_offense"] = {
            type = "DELETE",
            table = "omik_polititablet_sigtelser",
            where = "offense_id = @offense_id"
        },
        ["/create_offense"] = {
            type = "INSERT",
            table = "omik_polititablet_sigtelser",
            table_cols = "(offense_id, identifier, officer_id, date, officers, offenses, confiscated, lawyer, weapons_used, total_offense_amount, report)",
            insert_fields = "(NULL, @identifier, @officer_id, CURRENT_TIMESTAMP(), @officers, @offenses, @confiscated, @lawyer, @weapons_used, @total_offense_amount, @report)"
        },
        ["/edit_offense"] = {
            type = "UPDATE",
            table = "omik_polititablet_sigtelser sig",
            update_fields = {
                "sig.officers = @officers, sig.offenses = @offenses, sig.confiscated = @confiscated, sig.lawyer = @lawyer, sig.weapons_used = @weapons_used, sig.total_offense_amount = @total_offense_amount, sig.report = @report"
            },
            where = "sig.offense_id = @offense_id"
        },
        ["/create_offense_warrant"] = {
            type = "INSERT",
            table = "omik_polititablet_frakendelser",
            table_cols = "(id, identifier, expires)",
            insert_fields = "(NULL, @identifier, CURRENT_DATE() + INTERVAL @expires DAY)"
        },
        ["/search_offense"] = {
            type = "SELECT_JOIN",
            table = "players u",
            fields = {
                ["u.citizenid"] = "identifier",
                ["u.profile_logo"] = "profile_logo",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname'))"] = "firstname",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname'))"] = "lastname",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.birthdate'))"] = "dateofbirth",
                ["JSON_EXTRACT(u.charinfo, '$.gender')"] = "sex",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.phone'))"] = "phone_number",
                ["group_concat(DISTINCT CONCAT(' ', IFNULL(op.label, 'Ingen Adresse')))"] = "address",
                ["IFNULL(oe.type, 'no_warrant')"] = "warrant",
                ["IFNULL(of.expires, 'no_disq')"] = "disq"
            },
            joins = {
                "LEFT JOIN omik_polititablet_frakendelser of ON (of.identifier = u.citizenid COLLATE utf8mb4_general_ci)",
                "LEFT JOIN omik_polititablet_efterlysninger oe ON (oe.identifier = u.citizenid COLLATE utf8mb4_general_ci)",
                "LEFT JOIN apartments op ON (op.citizenid = u.citizenid COLLATE utf8mb4_general_ci)"
            },
            where = "CONCAT(JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname'))) LIKE @name AND JSON_EXTRACT(u.charinfo, '$.gender') LIKE @sex",
            extra = "group by u.citizenid LIMIT 0,30"
        },
        ["/search_offense_license"] = {
            type = "SELECT_JOIN",
            table = "players u",
            fields = {
                ["u.citizenid"] = "identifier",
                ["u.profile_logo"] = "profile_logo",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname'))"] = "firstname",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname'))"] = "lastname",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.birthdate'))"] = "dateofbirth",
                ["JSON_EXTRACT(u.charinfo, '$.gender')"] = "sex",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.phone'))"] = "phone_number",
                ["group_concat(DISTINCT CONCAT(' ', IFNULL(op.label, 'Ingen Adresse')))"] = "address",
                ["IFNULL(oe.type, 'no_warrant')"] = "warrant",
                ["IFNULL(of.expires, 'no_disq')"] = "disq",
                ["IF(JSON_EXTRACT(u.metadata, '$.licences.driver') = true, 'drive', 'no_drive')"] = "license"
            },
            joins = {
                "LEFT JOIN omik_polititablet_frakendelser of ON (of.identifier = u.citizenid COLLATE utf8mb4_general_ci)",
                "LEFT JOIN omik_polititablet_efterlysninger oe ON (oe.identifier = u.citizenid COLLATE utf8mb4_general_ci)",
                "LEFT JOIN apartments op ON (op.citizenid = u.citizenid COLLATE utf8mb4_general_ci)"
            },
            where = "CONCAT(JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname'))) LIKE @name AND JSON_EXTRACT(u.charinfo, '$.gender') LIKE @sex",
            extra = "group by u.citizenid LIMIT 0,30"
        },
        ["/user"] = {
            type = "SELECT_JOIN",
            table = "players u",
            fields = {
                ["u.profile_logo"] = "profile_logo",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname'))"] = "firstname",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname'))"] = "lastname",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.birthdate'))"] = "dateofbirth",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.phone'))"] = "phone_number",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.job, '$.label'))"] = "label",
                ["u.tablet_notes"] = "tablet_notes",
                ["IFNULL(oe.type, 'no_warrant')"] = "warrant",
                ["IFNULL(of.expires, 'no_disq')"] = "disq",
                ["u.citizenid"] = "identifier",
                ["JSON_EXTRACT(u.charinfo, '$.gender')"] = "sex",
                ["group_concat(DISTINCT CONCAT(' ', IFNULL(op.label, 'Ingen Adresse')))"] = "address"
            },
            joins = {
                "LEFT JOIN omik_polititablet_frakendelser of ON (of.identifier = u.citizenid COLLATE utf8mb4_general_ci)",
                "LEFT JOIN omik_polititablet_efterlysninger oe ON (oe.identifier = u.citizenid COLLATE utf8mb4_general_ci)",
                "LEFT JOIN apartments op ON (op.citizenid = u.citizenid COLLATE utf8mb4_general_ci)"
            },
            where = "u.citizenid = @identifier",
            extra = "group by u.citizenid"
        },
        ["/user_license"] = {
            type = "SELECT_JOIN",
            table = "players u",
            fields = {
                ["u.profile_logo"] = "profile_logo",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname'))"] = "firstname",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname'))"] = "lastname",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.birthdate'))"] = "dateofbirth",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.phone'))"] = "phone_number",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.job, '$.label'))"] = "label",
                ["u.tablet_notes"] = "tablet_notes",
                ["IFNULL(oe.type, 'no_warrant')"] = "warrant",
                ["IFNULL(of.expires, 'no_disq')"] = "disq",
                ["u.citizenid"] = "identifier",
                ["JSON_EXTRACT(u.charinfo, '$.gender')"] = "sex",
                ["group_concat(DISTINCT CONCAT(' ', IFNULL(op.label, 'Ingen Adresse')))"] = "address",
                ["IF(JSON_EXTRACT(u.metadata, '$.licences.driver') = true, 'drive', 'no_drive')"] = "license"
            },
            joins = {
                "LEFT JOIN omik_polititablet_frakendelser of ON (of.identifier = u.citizenid COLLATE utf8mb4_general_ci)",
                "LEFT JOIN omik_polititablet_efterlysninger oe ON (oe.identifier = u.citizenid COLLATE utf8mb4_general_ci)",
                "LEFT JOIN apartments op ON (op.citizenid = u.citizenid COLLATE utf8mb4_general_ci)"
            },
            where = "u.citizenid = @identifier",
            extra = "group by u.citizenid"
        },
        ["/user_offenses"] = {
            type = "SELECT",
            table = "omik_polititablet_sigtelser sig",
            fields = {
                ["sig.offense_id"] = "offense_id",
                ["sig.officer_id"] = "officer_id",
                ["sig.date"] = "date",
                ["sig.lawyer"] = "lawyer",
                ["sig.total_offense_amount"] = "total_offense_amount",
                ["sig.officers"] = "officers",
                ["sig.weapons_used"] = "weapons_used",
                ["sig.offenses"] = "offenses",
                ["sig.confiscated"] = "confiscated",
                ["sig.report"] = "report"
            },
            where = "identifier = @identifier"
        },
        ["/user_offenses_officers"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_ansatte an",
            fields = {
                ["CONCAT(JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname')))"] = "name",
                ["an.officer_id"] = "officer_id",
                ["an.badge_number"] = "badge_number",
                ["an.profile_logo"] = "profile_logo",
                ["an.rank"] = "rank"
            },
            joins = {"INNER JOIN players u ON u.officer_id = an.officer_id"}
        },
        ["/user_properties"] = {
            type = "SELECT",
            table = "apartments op",
            fields = {
                ["op.label"] = "name",
                ["op.citizenid"] = "owner"
            },
            where = "op.citizenid = @identifier"
        },
        ["/user_vehicles"] = {
            type = "SELECT_JOIN",
            table = "player_vehicles ov",
            fields = {
                ["ov.plate"] = "plate",
                ["ov.hash"] = "vehicle",
                ["ov.citizenid"] = "owner",
                ["ov.thumbnail"] = "thumbnail",
                ["IFNULL(oe.type, 'no_warrant')"] = "warrant"
            },
            joins = {
                "LEFT JOIN omik_polititablet_efterlysninger oe ON (oe.plate = ov.plate COLLATE utf8mb4_general_ci)"
            },
            where = "ov.citizenid = @identifier"
        },
        ["/user_logo"] = {
            type = "UPDATE",
            table = "players u",
            update_fields = {"u.profile_logo = @profile_logo"},
            where = "u.citizenid = @identifier"
        },
        ["/user/notes"] = {
            type = "UPDATE",
            table = "players u",
            update_fields = {"u.tablet_notes = @tablet_notes"},
            where = "u.citizenid = @identifier"
        },
        ["/latest"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_sigtelser sig",
            fields = {
                ["sig.offense_id"] = "offense_id",
                ["sig.identifier"] = "identifier",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname'))"] = "firstname",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname'))"] = "lastname",
                ["u.profile_logo"] = "user_profile_logo",
                ["an.profile_logo"] = "officer_profile_logo",
                ["sig.date"] = "date",
                ["CONCAT(JSON_UNQUOTE(JSON_EXTRACT(uo.charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(uo.charinfo, '$.lastname')))"] = "name",
                ["an.badge_number"] = "badge_number",
                ["sig.total_offense_amount"] = "total_offense_amount"
            },
            joins = {
                "LEFT JOIN players u ON sig.identifier = u.citizenid",
                "LEFT JOIN players uo ON sig.officer_id = uo.officer_id",
                "LEFT JOIN omik_polititablet_ansatte an ON sig.officer_id = an.officer_id"
            },
            extra = "ORDER BY sig.offense_id DESC LIMIT 3"
        }
    }
}

queries.officer = {
    esx = {
        ["/login_delete_warrants"] = {
            type = "DELETE",
            table = "omik_polititablet_frakendelser",
            where = "expires < CURRENT_DATE()"
        },
        ["/login_get_officer"] = {
            type = "SELECT",
            table = "omik_polititablet_ansatte an",
            fields = {
                ["an.officer_id"] = "officer_id",
                ["an.badge_number"] = "badge_number",
                ["an.on_duty"] = "on_duty",
                ["an.rank"] = "rank",
                ["an.responsible_area"] = "responsible_area",
                ["an.profile_logo"] = "profile_logo",
                ["an.employment_date"] = "employment_date",
                ["an.fleetStatus"] = "fleetStatus",
                ["an.permissions"] = "permissions"
            },
            where = "badge_number = @badge_number AND password = PASSWORD(@password)"
        },
        ["/login_get_officerExtra"] = {
            type = "SELECT_JOIN",
            table = "users u",
            fields = {
                ["u.phone_number"] = "phone_number",
                ["CONCAT(u.firstname, ' ', u.lastname)"] = "name",
                ["COUNT(sig.offense_id)"] = "total_cases"
            },
            joins = {"LEFT JOIN omik_polititablet_sigtelser sig ON sig.officer_id = u.officer_id"},
            where = "u.officer_id = @officer_id"
        },
        ["/details"] = {
            type = "SELECT_JOIN",
            table = "users u",
            fields = {
                ["an.officer_id"] = "officer_id",
                ["an.badge_number"] = "badge_number",
                ["an.on_duty"] = "on_duty",
                ["an.rank"] = "rank",
                ["an.responsible_area"] = "responsible_area",
                ["an.profile_logo"] = "profile_logo",
                ["an.employment_date"] = "employment_date",
                ["an.fleetStatus"] = "fleetStatus",
                ["an.certificates"] = "certificates",
                ["an.educations"] = "educations",
                ["an.permissions"] = "permissions",
                ["CONCAT(u.firstname, ' ', u.lastname)"] = "name",
                ["u.phone_number"] = "phone_number",
                ["group_concat(DISTINCT CONCAT(' ', IFNULL(op.name, 'Ingen Adresse')))"] = "address",
                ["COUNT(DISTINCT offense_id)"] = "total_cases"
            },
            joins = {
                "LEFT JOIN omik_polititablet_ansatte an ON an.officer_id = u.officer_id",
                "LEFT JOIN owned_properties op ON (op.owner = u.identifier COLLATE utf8mb4_general_ci)",
                "LEFT JOIN omik_polititablet_sigtelser si ON si.officer_id = u.officer_id"
            },
            where = "u.officer_id = @officer_id",
            extra = "GROUP BY u.officer_id"
        },
        ["/officerData_get_officer"] = {
            type = "SELECT",
            table = "users u",
            fields = {
                ["u.firstname"] = "firstname",
                ["u.lastname"] = "lastname",
                ["u.phone_number"] = "phone_number",
                ["u.dateofbirth"] = "dateofbirth",
                ["u.sex"] = "sex"
            },
            where = "u.officer_id = @officer_id"
        },
        ["/officerData_get_officers"] = {
            type = "SELECT",
            table = "omik_polititablet_ansatte an",
            fields = {
                ["an.officer_id"] = "officer_id",
                ["an.badge_number"] = "badge_number",
                ["an.on_duty"] = "on_duty",
                ["an.rank"] = "rank",
                ["an.responsible_area"] = "responsible_area",
                ["an.profile_logo"] = "profile_logo",
                ["an.employment_date"] = "employment_date",
                ["an.educations"] = "educations",
                ["an.certificates"] = "certificates",
                ["an.permissions"] = "permissions"
            }
        },
        ["/duty_update"] = {
            type = "UPDATE",
            table = "omik_polititablet_ansatte an",
            update_fields = {"an.on_duty = @on_duty"},
            where = "an.badge_number = @badge_number"
        },
        ["/password_update"] = {
            type = "UPDATE",
            table = "omik_polititablet_ansatte an",
            update_fields = {"an.password = PASSWORD(@password)"},
            where = "an.officer_id = @officer_id"
        },
        ["/fleetStatus_update"] = {
            type = "UPDATE",
            table = "omik_polititablet_ansatte an",
            update_fields = {"an.fleetStatus = @fleetStatus"},
            where = "an.officer_id = @officer_id"
        },
        ["/logo_update"] = {
            type = "UPDATE",
            table = "omik_polititablet_ansatte an",
            update_fields = {"an.profile_logo = @profile_logo"},
            where = "officer_id = @officer_id"
        }
    },
    vrp = {
        ["/login_delete_warrants"] = {
            type = "DELETE",
            table = "omik_polititablet_frakendelser",
            where = "expires < CURRENT_DATE()"
        },
        ["/login_get_officer"] = {
            type = "SELECT",
            table = "omik_polititablet_ansatte an",
            fields = {
                ["an.officer_id"] = "officer_id",
                ["an.badge_number"] = "badge_number",
                ["an.on_duty"] = "on_duty",
                ["an.rank"] = "rank",
                ["an.responsible_area"] = "responsible_area",
                ["an.profile_logo"] = "profile_logo",
                ["an.employment_date"] = "employment_date",
                ["an.fleetStatus"] = "fleetStatus",
                ["an.permissions"] = "permissions"
            },
            where = "badge_number = @badge_number AND password = PASSWORD(@password)"
        },
        ["/login_get_officerExtra"] = {
            type = "SELECT_JOIN",
            table = "vrp_user_identities u",
            fields = {
                ["u.phone"] = "phone_number",
                ["CONCAT(u.firstname, ' ', u.name)"] = "name",
                ["COUNT(sig.offense_id)"] = "total_cases"
            },
            joins = {"LEFT JOIN omik_polititablet_sigtelser sig ON sig.officer_id = u.officer_id"},
            where = "u.officer_id = @officer_id"
        },
        ["/details"] = {
            type = "SELECT_JOIN",
            table = "vrp_user_identities u",
            fields = {
                ["an.officer_id"] = "officer_id",
                ["an.badge_number"] = "badge_number",
                ["an.on_duty"] = "on_duty",
                ["an.rank"] = "rank",
                ["an.responsible_area"] = "responsible_area",
                ["an.profile_logo"] = "profile_logo",
                ["an.employment_date"] = "employment_date",
                ["an.fleetStatus"] = "fleetStatus",
                ["an.certificates"] = "certificates",
                ["an.educations"] = "educations",
                ["an.permissions"] = "permissions",
                ["CONCAT(u.firstname, ' ', u.name)"] = "name",
                ["u.phone"] = "phone_number",
                ["group_concat(DISTINCT CONCAT(' ', IFNULL(op.home, 'Ingen Adresse')))"] = "address",
                ["COUNT(DISTINCT offense_id)"] = "total_cases"
            },
            joins = {
                "LEFT JOIN omik_polititablet_ansatte an ON an.officer_id = u.officer_id",
                "LEFT JOIN vrp_user_homes op ON op.user_id = u.user_id",
                "LEFT JOIN omik_polititablet_sigtelser si ON si.officer_id = u.officer_id"
            },
            where = "u.officer_id = @officer_id",
            extra = "GROUP BY u.officer_id"
        },
        ["/officerData_get_officer"] = {
            type = "SELECT",
            table = "vrp_user_identities u",
            fields = {
                ["u.firstname"] = "firstname",
                ["u.name"] = "lastname",
                ["u.phone"] = "phone_number",
                ["DATE_FORMAT(CURRENT_DATE() - INTERVAL u.age YEAR, '%d-%m-%Y')"] = "dateofbirth"
            },
            where = "u.officer_id = @officer_id"
        },
        ["/officerData_get_officers"] = {
            type = "SELECT",
            table = "omik_polititablet_ansatte an",
            fields = {
                ["an.officer_id"] = "officer_id",
                ["an.badge_number"] = "badge_number",
                ["an.on_duty"] = "on_duty",
                ["an.rank"] = "rank",
                ["an.responsible_area"] = "responsible_area",
                ["an.profile_logo"] = "profile_logo",
                ["an.employment_date"] = "employment_date",
                ["an.educations"] = "educations",
                ["an.certificates"] = "certificates",
                ["an.permissions"] = "permissions"
            }
        },
        ["/duty_update"] = {
            type = "UPDATE",
            table = "omik_polititablet_ansatte an",
            update_fields = {"an.on_duty = @on_duty"},
            where = "an.badge_number = @badge_number"
        },
        ["/password_update"] = {
            type = "UPDATE",
            table = "omik_polititablet_ansatte an",
            update_fields = {"an.password = PASSWORD(@password)"},
            where = "an.officer_id = @officer_id"
        },
        ["/fleetStatus_update"] = {
            type = "UPDATE",
            table = "omik_polititablet_ansatte an",
            update_fields = {"an.fleetStatus = @fleetStatus"},
            where = "an.officer_id = @officer_id"
        },
        ["/logo_update"] = {
            type = "UPDATE",
            table = "omik_polititablet_ansatte",
            update_fields = {"profile_logo = @profile_logo"},
            where = "officer_id = @officer_id"
        }
    },
    qbcore = {
        ["/login_delete_warrants"] = {
            type = "DELETE",
            table = "omik_polititablet_frakendelser",
            where = "expires < CURRENT_DATE()"
        },
        ["/login_get_officer"] = {
            type = "SELECT",
            table = "omik_polititablet_ansatte an",
            fields = {
                ["an.officer_id"] = "officer_id",
                ["an.badge_number"] = "badge_number",
                ["an.on_duty"] = "on_duty",
                ["an.rank"] = "rank",
                ["an.responsible_area"] = "responsible_area",
                ["an.profile_logo"] = "profile_logo",
                ["an.employment_date"] = "employment_date",
                ["an.fleetStatus"] = "fleetStatus",
                ["an.permissions"] = "permissions"
            },
            where = "badge_number = @badge_number AND password = PASSWORD(@password)"
        },
        ["/login_get_officerExtra"] = {
            type = "SELECT_JOIN",
            table = "players u",
            fields = {
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.phone'))"] = "phone_number",
                ["CONCAT(JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname')))"] = "name",
                ["COUNT(sig.offense_id)"] = "total_cases"
            },
            joins = {"LEFT JOIN omik_polititablet_sigtelser sig ON sig.officer_id = u.officer_id"},
            where = "u.officer_id = @officer_id"
        },
        ["/details"] = {
            type = "SELECT_JOIN",
            table = "players u",
            fields = {
                ["an.officer_id"] = "officer_id",
                ["an.badge_number"] = "badge_number",
                ["an.on_duty"] = "on_duty",
                ["an.rank"] = "rank",
                ["an.responsible_area"] = "responsible_area",
                ["an.profile_logo"] = "profile_logo",
                ["an.employment_date"] = "employment_date",
                ["an.fleetStatus"] = "fleetStatus",
                ["an.certificates"] = "certificates",
                ["an.educations"] = "educations",
                ["an.permissions"] = "permissions",
                ["CONCAT(JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname')))"] = "name",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.phone'))"] = "phone_number",
                ["group_concat(DISTINCT CONCAT(' ', IFNULL(op.label, 'Ingen Adresse')))"] = "address",
                ["COUNT(DISTINCT offense_id)"] = "total_cases"
            },
            joins = {
                "LEFT JOIN omik_polititablet_ansatte an ON an.officer_id = u.officer_id",
                "LEFT JOIN apartments op ON (op.citizenid = u.citizenid COLLATE utf8mb4_general_ci)",
                "LEFT JOIN omik_polititablet_sigtelser si ON si.officer_id = u.officer_id"
            },
            where = "u.officer_id = @officer_id",
            extra = "GROUP BY u.officer_id"
        },
        ["/officerData_get_officer"] = {
            type = "SELECT",
            table = "players u",
            fields = {
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname'))"] = "firstname",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname'))"] = "lastname",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.phone'))"] = "phone_number",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.birthdate'))"] = "dateofbirth",
                ["JSON_EXTRACT(u.charinfo, '$.gender')"] = "sex"
            },
            where = "u.officer_id = @officer_id"
        },
        ["/officerData_get_officers"] = {
            type = "SELECT",
            table = "omik_polititablet_ansatte an",
            fields = {
                ["an.officer_id"] = "officer_id",
                ["an.badge_number"] = "badge_number",
                ["an.on_duty"] = "on_duty",
                ["an.rank"] = "rank",
                ["an.responsible_area"] = "responsible_area",
                ["an.profile_logo"] = "profile_logo",
                ["an.employment_date"] = "employment_date",
                ["an.educations"] = "educations",
                ["an.certificates"] = "certificates",
                ["an.permissions"] = "permissions"
            }
        },
        ["/duty_update"] = {
            type = "UPDATE",
            table = "omik_polititablet_ansatte an",
            update_fields = {"an.on_duty = @on_duty"},
            where = "an.badge_number = @badge_number"
        },
        ["/password_update"] = {
            type = "UPDATE",
            table = "omik_polititablet_ansatte an",
            update_fields = {"an.password = PASSWORD(@password)"},
            where = "an.officer_id = @officer_id"
        },
        ["/fleetStatus_update"] = {
            type = "UPDATE",
            table = "omik_polititablet_ansatte an",
            update_fields = {"an.fleetStatus = @fleetStatus"},
            where = "an.officer_id = @officer_id"
        },
        ["/logo_update"] = {
            type = "UPDATE",
            table = "omik_polititablet_ansatte an",
            update_fields = {"an.profile_logo = @profile_logo"},
            where = "officer_id = @officer_id"
        }
    }
}

queries.stats = {
    esx = {
        ["/total_cases"] = {
            type = "SELECT",
            table = "omik_polititablet_sigtelser",
            fields = {
                ["COUNT(*)"] = "total_cases"
            }
        },
        ["/total_wanted"] = {
            type = "SELECT",
            table = "omik_polititablet_efterlysninger",
            fields = {
                ["COUNT(*)"] = "total_wanted"
            }
        },
        ["/total_citizens"] = {
            type = "SELECT",
            table = "users",
            fields = {
                ["COUNT(*)"] = "total_citizens"
            }
        },
        ["/total_vehicles"] = {
            type = "SELECT",
            table = "owned_vehicles",
            fields = {
                ["COUNT(*)"] = "total_vehicles"
            }
        }
    },
    vrp = {
        ["/total_cases"] = {
            type = "SELECT",
            table = "omik_polititablet_sigtelser",
            fields = {
                ["COUNT(*)"] = "total_cases"
            }
        },
        ["/total_wanted"] = {
            type = "SELECT",
            table = "omik_polititablet_efterlysninger",
            fields = {
                ["COUNT(*)"] = "total_wanted"
            }
        },
        ["/total_citizens"] = {
            type = "SELECT",
            table = "vrp_user_identities",
            fields = {
                ["COUNT(*)"] = "total_citizens"
            }
        },
        ["/total_vehicles"] = {
            type = "SELECT",
            table = "vrp_user_vehicles",
            fields = {
                ["COUNT(*)"] = "total_vehicles"
            }
        }
    },
    qbcore = {
        ["/total_cases"] = {
            type = "SELECT",
            table = "omik_polititablet_sigtelser",
            fields = {
                ["COUNT(*)"] = "total_cases"
            }
        },
        ["/total_wanted"] = {
            type = "SELECT",
            table = "omik_polititablet_efterlysninger",
            fields = {
                ["COUNT(*)"] = "total_wanted"
            }
        },
        ["/total_citizens"] = {
            type = "SELECT",
            table = "players",
            fields = {
                ["COUNT(*)"] = "total_citizens"
            }
        },
        ["/total_vehicles"] = {
            type = "SELECT",
            table = "player_vehicles",
            fields = {
                ["COUNT(*)"] = "total_vehicles"
            }
        }
    }
}

queries.vehicles = {
    esx = {
        ["/search_numberplate"] = {
            type = "SELECT_JOIN",
            table = "users u, owned_vehicles ov",
            fields = {
                ["u.identifier"] = "identifier",
                ["ov.thumbnail"] = "thumbnail",
                ["ov.plate"] = "plate",
                ["u.profile_logo"] = "profile_logo",
                ["CONCAT(u.firstname, ' ', u.lastname)"] = "name",
                ["ov.vehicle"] = "vehicle",
                ["ov.type"] = "type",
                ["IFNULL(oe.type, 'no_warrant')"] = "warrant"
            },
            joins = {
                "LEFT JOIN omik_polititablet_efterlysninger oe ON (oe.plate = ov.plate COLLATE utf8mb4_general_ci)"
            },
            where = "u.identifier = ov.owner AND ov.plate LIKE @plate",
            extra = "LIMIT 0,30"
        },
        ["/search_name"] = {
            type = "SELECT_JOIN",
            table = "users u, owned_vehicles ov",
            fields = {
                ["u.identifier"] = "identifier",
                ["ov.thumbnail"] = "thumbnail",
                ["ov.plate"] = "plate",
                ["u.profile_logo"] = "profile_logo",
                ["CONCAT(u.firstname, ' ', u.lastname)"] = "name",
                ["ov.vehicle"] = "vehicle",
                ["ov.type"] = "type",
                ["IFNULL(oe.type, 'no_warrant')"] = "warrant"
            },
            joins = {
                "LEFT JOIN omik_polititablet_efterlysninger oe ON (oe.plate = ov.plate COLLATE utf8mb4_general_ci)"
            },
            where = "u.identifier = ov.owner AND CONCAT(u.firstname, ' ', u.lastname) LIKE @name",
            extra = "LIMIT 0,30"
        },
        ["/thumbnail_update"] = {
            type = "UPDATE",
            table = "owned_vehicles ov",
            update_fields = {"ov.thumbnail = @thumbnail"},
            where = "ov.plate = @plate"
        }
    },
    vrp = {
        ["/search_numberplate"] = {
            type = "SELECT_JOIN",
            table = "vrp_user_identities u, vrp_user_vehicles ov",
            fields = {
                ["u.user_id"] = "identifier",
                ["ov.thumbnail"] = "thumbnail",
                ["ov.vehicle_plate"] = "plate",
                ["u.profile_logo"] = "profile_logo",
                ["CONCAT(u.firstname, ' ', u.name)"] = "name",
                ["ov.vehicle"] = "vehicle_name",
                ["ov.veh_type"] = "type",
                ["IFNULL(oe.type, 'no_warrant')"] = "warrant"
            },
            joins = {
                "LEFT JOIN omik_polititablet_efterlysninger oe ON (oe.plate = ov.vehicle_plate COLLATE utf8mb4_general_ci)"
            },
            where = "u.user_id = ov.user_id AND ov.vehicle_plate LIKE @plate",
            extra = "LIMIT 0,30"
        },
        ["/search_name"] = {
            type = "SELECT_JOIN",
            table = "vrp_user_identities u, vrp_user_vehicles ov",
            fields = {
                ["u.user_id"] = "identifier",
                ["ov.thumbnail"] = "thumbnail",
                ["ov.vehicle_plate"] = "plate",
                ["u.profile_logo"] = "profile_logo",
                ["CONCAT(u.firstname, ' ', u.name)"] = "name",
                ["ov.vehicle"] = "vehicle_name",
                ["ov.veh_type"] = "type",
                ["IFNULL(oe.type, 'no_warrant')"] = "warrant"
            },
            joins = {
                "LEFT JOIN omik_polititablet_efterlysninger oe ON (oe.plate = ov.vehicle_plate COLLATE utf8mb4_general_ci)"
            },
            where = "u.user_id = ov.user_id AND CONCAT(u.firstname, ' ', u.name) LIKE @name",
            extra = "LIMIT 0,30"
        },
        ["/thumbnail_update"] = {
            type = "UPDATE",
            table = "vrp_user_vehicles ov",
            update_fields = {"ov.thumbnail = @thumbnail"},
            where = "ov.vehicle_plate = @plate"
        }
    },
    qbcore = {
        ["/search_numberplate"] = {
            type = "SELECT_JOIN",
            table = "players u, player_vehicles ov",
            fields = {
                ["u.citizenid"] = "identifier",
                ["ov.thumbnail"] = "thumbnail",
                ["ov.plate"] = "plate",
                ["u.profile_logo"] = "profile_logo",
                ["CONCAT(JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname')))"] = "name",
                ["ov.hash"] = "vehicle",
                ["IFNULL(oe.type, 'no_warrant')"] = "warrant"
            },
            joins = {
                "LEFT JOIN omik_polititablet_efterlysninger oe ON (oe.plate = ov.plate COLLATE utf8mb4_general_ci)"
            },
            where = "u.citizenid = ov.citizenid AND ov.plate LIKE @plate",
            extra = "LIMIT 0,30"
        },
        ["/search_name"] = {
            type = "SELECT_JOIN",
            table = "players u, player_vehicles ov",
            fields = {
                ["u.citizenid"] = "identifier",
                ["ov.thumbnail"] = "thumbnail",
                ["ov.plate"] = "plate",
                ["u.profile_logo"] = "profile_logo",
                ["CONCAT(JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname')))"] = "name",
                ["ov.hash"] = "vehicle",
                ["IFNULL(oe.type, 'no_warrant')"] = "warrant"
            },
            joins = {
                "LEFT JOIN omik_polititablet_efterlysninger oe ON (oe.plate = ov.plate COLLATE utf8mb4_general_ci)"
            },
            where = "u.citizenid = ov.citizenid AND CONCAT(JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname'))) LIKE @name",
            extra = "LIMIT 0,30"
        },
        ["/thumbnail_update"] = {
            type = "UPDATE",
            table = "player_vehicles ov",
            update_fields = {"ov.thumbnail = @thumbnail"},
            where = "ov.plate = @plate"
        }
    }
}

queries.warrants = {
    esx = {
        ["/person_wantedPeople_name"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_efterlysninger o",
            fields = {
                ["u.profile_logo"] = "profile_logo",
                ["CONCAT(u.firstname, ' ', u.lastname)"] = "name",
                ["o.id"] = "id",
                ["u.phone_number"] = "phone_number",
                ["group_concat(DISTINCT CONCAT(' ', IFNULL(op.name, 'Ingen Adresse')))"] = "address",
                ["o.identifier"] = "identifier",
                ["o.offenses"] = "offenses",
                ["u.dateofbirth"] = "dateofbirth",
                ["u.sex"] = "sex",
                ["o.officer_id"] = "officer_id",
                ["o.date"] = "date",
                ["o.description"] = "description"
            },
            joins = {
                "LEFT JOIN users u ON (u.identifier = o.identifier COLLATE utf8mb4_general_ci)",
                "LEFT JOIN owned_properties op ON (op.owner = o.identifier COLLATE utf8mb4_general_ci)"
            },
            where = "CONCAT(u.firstname, ' ', u.lastname) LIKE @name AND o.type = 'person'",
            extra = "group by o.id LIMIT 0,30"
        },
        ["/person_wantedPeople_phone"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_efterlysninger o",
            fields = {
                ["u.profile_logo"] = "profile_logo",
                ["CONCAT(u.firstname, ' ', u.lastname)"] = "name",
                ["o.id"] = "id",
                ["u.phone_number"] = "phone_number",
                ["group_concat(DISTINCT CONCAT(' ', IFNULL(op.name, 'Ingen Adresse')))"] = "address",
                ["o.identifier"] = "identifier",
                ["o.offenses"] = "offenses",
                ["u.dateofbirth"] = "dateofbirth",
                ["u.sex"] = "sex",
                ["o.officer_id"] = "officer_id",
                ["o.date"] = "date",
                ["o.description"] = "description"
            },
            joins = {
                "LEFT JOIN users u ON (u.identifier = o.identifier COLLATE utf8mb4_general_ci)",
                "LEFT JOIN owned_properties op ON (op.owner = o.identifier COLLATE utf8mb4_general_ci)"
            },
            where = "u.phone_number LIKE @phone_number AND o.type = 'person'",
            extra = "group by o.id LIMIT 0,30"
        },
        ["/person_ansatte"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_ansatte an",
            fields = {
                ["CONCAT(u.firstname, ' ', u.lastname)"] = "name",
                ["an.officer_id"] = "officer_id",
                ["an.badge_number"] = "badge_number",
                ["an.profile_logo"] = "profile_logo"
            },
            joins = {"INNER JOIN users u ON u.officer_id = an.officer_id"}
        },
        ["/person_find"] = {
            type = "SELECT_JOIN",
            table = "users u",
            fields = {
                ["u.profile_logo"] = "profile_logo",
                ["u.firstname"] = "firstname",
                ["u.lastname"] = "lastname",
                ["u.dateofbirth"] = "dateofbirth",
                ["u.sex"] = "sex",
                ["u.phone_number"] = "phone_number",
                ["u.identifier"] = "identifier",
                ["group_concat(DISTINCT CONCAT(' ', IFNULL(op.name, 'Ingen Adresse')))"] = "address"
            },
            joins = {"LEFT JOIN owned_properties op ON (op.owner = u.identifier COLLATE utf8mb4_general_ci)"},
            where = "CONCAT(u.firstname, ' ', u.lastname) LIKE @name",
            extra = "group by u.identifier LIMIT 0,30"
        },
        ["/vehicle_vehicles_plate"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_efterlysninger o",
            fields = {
                ["o.id"] = "id",
                ["ov.plate"] = "plate",
                ["IFNULL(u.profile_logo, 'https://i.imgur.com/YSXdYqv.png')"] = "profile_logo",
                ["IFNULL(CONCAT(u.firstname, ' ', u.lastname), 'Ukendt ejer')"] = "name",
                ["IFNULL(u.phone_number, 'Ukendt nummer')"] = "phone_number",
                ["ov.thumbnail"] = "thumbnail",
                ["ov.vehicle"] = "vehicle",
                ["o.offenses"] = "offenses",
                ["o.date"] = "date",
                ["o.officer_id"] = "officer_id",
                ["o.description"] = "description"
            },
            joins = {
                "LEFT JOIN owned_vehicles ov ON (ov.plate = o.plate COLLATE utf8mb4_general_ci)",
                "LEFT JOIN users u ON (u.identifier = ov.owner COLLATE utf8mb4_general_ci)"
            },
            where = "o.plate LIKE @plate AND o.type = 'vehicle'",
            extra = "GROUP BY o.plate LIMIT 0,30"
        },
        ["/vehicle_vehicles_name"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_efterlysninger o",
            fields = {
                ["o.id"] = "id",
                ["ov.plate"] = "plate",
                ["IFNULL(u.profile_logo, 'https://i.imgur.com/YSXdYqv.png')"] = "profile_logo",
                ["IFNULL(CONCAT(u.firstname, ' ', u.lastname), 'Ukendt ejer')"] = "name",
                ["IFNULL(u.phone_number, 'Ukendt nummer')"] = "phone_number",
                ["ov.thumbnail"] = "thumbnail",
                ["ov.vehicle"] = "vehicle",
                ["o.offenses"] = "offenses",
                ["o.date"] = "date",
                ["o.officer_id"] = "officer_id",
                ["o.description"] = "description"
            },
            joins = {
                "LEFT JOIN owned_vehicles ov ON (ov.plate = o.plate COLLATE utf8mb4_general_ci)",
                "LEFT JOIN users u ON (u.identifier = ov.owner COLLATE utf8mb4_general_ci)"
            },
            where = "CONCAT(u.firstname, ' ', u.lastname) LIKE @name AND o.plate=ov.plate",
            extra = "GROUP BY o.plate LIMIT 0,30"
        },
        ["/vehicle_ansatte"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_ansatte an",
            fields = {
                ["CONCAT(u.firstname, ' ', u.lastname)"] = "name",
                ["an.officer_id"] = "officer_id",
                ["an.badge_number"] = "badge_number",
                ["an.profile_logo"] = "profile_logo"
            },
            joins = {"INNER JOIN users u ON u.officer_id = an.officer_id"}
        },
        ["/vehicle_find"] = {
            type = "SELECT_JOIN",
            table = "owned_vehicles ov",
            fields = {
                ["ov.plate"] = "plate",
                ["ov.vehicle"] = "vehicle",
                ["CONCAT(u.firstname, ' ', u.lastname)"] = "name",
                ["u.profile_logo"] = "profile_logo",
                ["ov.thumbnail"] = "thumbnail"
            },
            joins = {"LEFT JOIN users u ON (u.identifier = ov.owner COLLATE utf8mb4_general_ci)"},
            where = "ov.plate LIKE @plate",
            extra = "LIMIT 0,30"
        },
        ["/create"] = {
            type = "INSERT",
            table = "omik_polititablet_efterlysninger",
            table_cols = "(id, type, plate, identifier, description, offenses, officer_id, date)",
            insert_fields = "(NULL, @type, @plate, @identifier, @description, @offenses, @officer_id, CURRENT_TIMESTAMP())"
        },
        ["/edit_person"] = {
            type = "UPDATE",
            table = "omik_polititablet_efterlysninger ef",
            update_fields = {"ef.description = @description, ef.offenses = @offenses"},
            where = "ef.identifier = @identifier"
        },
        ["/edit_vehicle"] = {
            type = "UPDATE",
            table = "omik_polititablet_efterlysninger ef",
            update_fields = {"ef.description = @description, ef.offenses = @offenses"},
            where = "ef.plate = @plate"
        },
        ["/delete"] = {
            type = "DELETE",
            table = "omik_polititablet_efterlysninger",
            where = "id = @id"
        }
    },
    vrp = {
        ["/person_wantedPeople_name"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_efterlysninger o",
            fields = {
                ["u.profile_logo"] = "profile_logo",
                ["CONCAT(u.firstname, ' ', u.name)"] = "name",
                ["o.id"] = "id",
                ["u.phone"] = "phone_number",
                ["group_concat(DISTINCT CONCAT(' ', IFNULL(op.home, 'Ingen Adresse')))"] = "address",
                ["o.identifier"] = "identifier",
                ["o.offenses"] = "offenses",
                ["DATE_FORMAT(CURRENT_DATE() - INTERVAL u.age YEAR, '%d-%m-%Y')"] = "dateofbirth",
                ["o.officer_id"] = "officer_id",
                ["o.date"] = "date",
                ["o.description"] = "description"
            },
            joins = {
                "LEFT JOIN vrp_user_identities u ON u.user_id = o.identifier",
                "LEFT JOIN vrp_user_homes op ON op.user_id = o.identifier"
            },
            where = "CONCAT(u.firstname, ' ', u.name) LIKE @name AND o.type = 'person'",
            extra = "group by o.id LIMIT 0,30"
        },
        ["/person_wantedPeople_phone"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_efterlysninger o",
            fields = {
                ["u.profile_logo"] = "profile_logo",
                ["CONCAT(u.firstname, ' ', u.name)"] = "name",
                ["o.id"] = "id",
                ["u.phone"] = "phone_number",
                ["group_concat(DISTINCT CONCAT(' ', IFNULL(op.home, 'Ingen Adresse')))"] = "address",
                ["o.identifier"] = "identifier",
                ["o.offenses"] = "offenses",
                ["DATE_FORMAT(CURRENT_DATE() - INTERVAL u.age YEAR, '%d-%m-%Y')"] = "dateofbirth",
                ["o.officer_id"] = "officer_id",
                ["o.date"] = "date",
                ["o.description"] = "description"
            },
            joins = {
                "LEFT JOIN vrp_user_identities u ON u.user_id = o.identifier",
                "LEFT JOIN vrp_user_homes op ON op.user_id = o.identifier"
            },
            where = "u.phone LIKE @phone_number AND o.type = 'person'",
            extra = "group by o.id LIMIT 0,30"
        },
        ["/person_ansatte"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_ansatte an",
            fields = {
                ["CONCAT(u.firstname, ' ', u.name)"] = "name",
                ["an.officer_id"] = "officer_id",
                ["an.badge_number"] = "badge_number",
                ["an.profile_logo"] = "profile_logo"
            },
            joins = {"INNER JOIN vrp_user_identities u ON u.officer_id = an.officer_id"}
        },
        ["/person_find"] = {
            type = "SELECT_JOIN",
            table = "vrp_user_identities u",
            fields = {
                ["u.profile_logo"] = "profile_logo",
                ["u.firstname"] = "firstname",
                ["u.name"] = "lastname",
                ["DATE_FORMAT(CURRENT_DATE() - INTERVAL u.age YEAR, '%d-%m-%Y')"] = "dateofbirth",
                ["u.phone"] = "phone_number",
                ["u.user_id"] = "identifier",
                ["group_concat(DISTINCT CONCAT(' ', IFNULL(op.home, 'Ingen Adresse')))"] = "address"
            },
            joins = {"LEFT JOIN vrp_user_homes op ON op.user_id = u.user_id"},
            where = "CONCAT(u.firstname, ' ', u.name) LIKE @name",
            extra = "group by u.user_id LIMIT 0,30"
        },
        ["/vehicle_vehicles_plate"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_efterlysninger o",
            fields = {
                ["o.id"] = "id",
                ["ov.vehicle_plate"] = "plate",
                ["IFNULL(u.profile_logo, 'https://i.imgur.com/YSXdYqv.png')"] = "profile_logo",
                ["IFNULL(CONCAT(u.firstname, ' ', u.name), 'Ukendt ejer')"] = "name",
                ["IFNULL(u.phone, 'Ukendt nummer')"] = "phone_number",
                ["ov.thumbnail"] = "thumbnail",
                ["ov.vehicle"] = "vehicle_name",
                ["o.offenses"] = "offenses",
                ["o.date"] = "date",
                ["o.officer_id"] = "officer_id",
                ["o.description"] = "description"
            },
            joins = {
                "LEFT JOIN vrp_user_vehicles ov ON (ov.vehicle_plate = o.plate COLLATE utf8mb4_general_ci)",
                "LEFT JOIN vrp_user_identities u ON u.user_id = ov.user_id"
            },
            where = "o.plate LIKE @plate AND o.type = 'vehicle'",
            extra = "GROUP BY o.plate LIMIT 0,30"
        },
        ["/vehicle_vehicles_name"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_efterlysninger o",
            fields = {
                ["o.id"] = "id",
                ["ov.vehicle_plate"] = "plate",
                ["IFNULL(u.profile_logo, 'https://i.imgur.com/YSXdYqv.png')"] = "profile_logo",
                ["IFNULL(CONCAT(u.firstname, ' ', u.name), 'Ukendt ejer')"] = "name",
                ["IFNULL(u.phone, 'Ukendt nummer')"] = "phone_number",
                ["ov.thumbnail"] = "thumbnail",
                ["ov.vehicle"] = "vehicle_name",
                ["o.offenses"] = "offenses",
                ["o.date"] = "date",
                ["o.officer_id"] = "officer_id",
                ["o.description"] = "description"
            },
            joins = {
                "LEFT JOIN vrp_user_vehicles ov ON (ov.vehicle_plate = o.plate COLLATE utf8mb4_general_ci)",
                "LEFT JOIN vrp_user_identities u ON u.user_id = ov.user_id"
            },
            where = "CONCAT(u.firstname, ' ', u.name) LIKE @name AND o.plate=ov.vehicle_plate",
            extra = "GROUP BY o.plate LIMIT 0,30"
        },
        ["/vehicle_ansatte"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_ansatte an",
            fields = {
                ["CONCAT(u.firstname, ' ', u.name)"] = "name",
                ["an.officer_id"] = "officer_id",
                ["an.badge_number"] = "badge_number",
                ["an.profile_logo"] = "profile_logo"
            },
            joins = {"INNER JOIN vrp_user_identities u ON u.officer_id = an.officer_id"}
        },
        ["/vehicle_find"] = {
            type = "SELECT_JOIN",
            table = "vrp_user_vehicles ov",
            fields = {
                ["ov.vehicle_plate"] = "plate",
                ["ov.vehicle"] = "vehicle_name",
                ["CONCAT(u.firstname, ' ', u.name)"] = "name",
                ["u.profile_logo"] = "profile_logo",
                ["ov.thumbnail"] = "thumbnail"
            },
            joins = {"LEFT JOIN vrp_user_identities u ON u.user_id = ov.user_id"},
            where = "ov.vehicle_plate LIKE @plate",
            extra = "LIMIT 0,30"
        },
        ["/create"] = {
            type = "INSERT",
            table = "omik_polititablet_efterlysninger",
            table_cols = "(id, type, plate, identifier, description, offenses, officer_id, date)",
            insert_fields = "(NULL, @type, @plate, @identifier, @description, @offenses, @officer_id, CURRENT_TIMESTAMP())"
        },
        ["/edit_person"] = {
            type = "UPDATE",
            table = "omik_polititablet_efterlysninger ef",
            update_fields = {"ef.description = @description, ef.offenses = @offenses"},
            where = "ef.identifier = @identifier"
        },
        ["/edit_vehicle"] = {
            type = "UPDATE",
            table = "omik_polititablet_efterlysninger ef",
            update_fields = {"ef.description = @description, ef.offenses = @offenses"},
            where = "ef.plate = @plate"
        },
        ["/delete"] = {
            type = "DELETE",
            table = "omik_polititablet_efterlysninger",
            where = "id = @id"
        }
    },
    qbcore = {
        ["/person_wantedPeople_name"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_efterlysninger o",
            fields = {
                ["u.profile_logo"] = "profile_logo",
                ["CONCAT(JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname')))"] = "name",
                ["o.id"] = "id",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.phone'))"] = "phone_number",
                ["group_concat(DISTINCT CONCAT(' ', IFNULL(op.label, 'Ingen Adresse')))"] = "address",
                ["o.identifier"] = "identifier",
                ["o.offenses"] = "offenses",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.birthdate'))"] = "dateofbirth",
                ["JSON_EXTRACT(u.charinfo, '$.gender')"] = "sex",
                ["o.officer_id"] = "officer_id",
                ["o.date"] = "date",
                ["o.description"] = "description"
            },
            joins = {
                "LEFT JOIN players u ON (u.citizenid = o.identifier COLLATE utf8mb4_general_ci)",
                "LEFT JOIN apartments op ON (op.citizenid = o.identifier COLLATE utf8mb4_general_ci)"
            },
            where = "CONCAT(JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname'))) LIKE @name AND o.type = 'person'",
            extra = "group by o.id LIMIT 0,30"
        },
        ["/person_wantedPeople_phone"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_efterlysninger o",
            fields = {
                ["u.profile_logo"] = "profile_logo",
                ["CONCAT(JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname')))"] = "name",
                ["o.id"] = "id",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.phone'))"] = "phone_number",
                ["group_concat(DISTINCT CONCAT(' ', IFNULL(op.label, 'Ingen Adresse')))"] = "address",
                ["o.identifier"] = "identifier",
                ["o.offenses"] = "offenses",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.birthdate'))"] = "dateofbirth",
                ["JSON_EXTRACT(u.charinfo, '$.gender')"] = "sex",
                ["o.officer_id"] = "officer_id",
                ["o.date"] = "date",
                ["o.description"] = "description"
            },
            joins = {
                "LEFT JOIN players u ON (u.citizenid = o.identifier COLLATE utf8mb4_general_ci)",
                "LEFT JOIN apartments op ON (op.citizenid = o.identifier COLLATE utf8mb4_general_ci)"
            },
            where = "JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.phone')) LIKE @phone_number AND o.type = 'person'",
            extra = "group by o.id LIMIT 0,30"
        },
        ["/person_ansatte"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_ansatte an",
            fields = {
                ["CONCAT(JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname')))"] = "name",
                ["an.officer_id"] = "officer_id",
                ["an.badge_number"] = "badge_number",
                ["an.profile_logo"] = "profile_logo"
            },
            joins = {"INNER JOIN players u ON u.officer_id = an.officer_id"}
        },
        ["/person_find"] = {
            type = "SELECT_JOIN",
            table = "players u",
            fields = {
                ["u.profile_logo"] = "profile_logo",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname'))"] = "firstname",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname'))"] = "lastname",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.birthdate'))"] = "dateofbirth",
                ["JSON_EXTRACT(u.charinfo, '$.gender')"] = "sex",
                ["JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.phone'))"] = "phone_number",
                ["u.citizenid"] = "identifier",
                ["group_concat(DISTINCT CONCAT(' ', IFNULL(op.label, 'Ingen Adresse')))"] = "address"
            },
            joins = {"LEFT JOIN apartments op ON (op.citizenid = u.citizenid COLLATE utf8mb4_general_ci)"},
            where = "CONCAT(JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname'))) LIKE @name",
            extra = "group by u.citizenid LIMIT 0,30"
        },
        ["/vehicle_vehicles_plate"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_efterlysninger o",
            fields = {
                ["o.id"] = "id",
                ["ov.plate"] = "plate",
                ["IFNULL(u.profile_logo, 'https://i.imgur.com/YSXdYqv.png')"] = "profile_logo",
                ["IFNULL(CONCAT(JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname'))), 'Ukendt ejer')"] = "name",
                ["IFNULL(JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.phone')), 'Ukendt nummer')"] = "phone_number",
                ["ov.thumbnail"] = "thumbnail",
                ["ov.hash"] = "vehicle",
                ["o.offenses"] = "offenses",
                ["o.date"] = "date",
                ["o.officer_id"] = "officer_id",
                ["o.description"] = "description"
            },
            joins = {
                "LEFT JOIN player_vehicles ov ON (ov.plate = o.plate COLLATE utf8mb4_general_ci)",
                "LEFT JOIN apartments op ON (op.citizenid = ov.citizenid COLLATE utf8mb4_general_ci)",
                "LEFT JOIN players u ON (u.citizenid = ov.citizenid COLLATE utf8mb4_general_ci)"
            },
            where = "o.plate LIKE @plate AND o.type = 'vehicle'",
            extra = "GROUP BY o.plate LIMIT 0,30"
        },
        ["/vehicle_vehicles_name"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_efterlysninger o",
            fields = {
                ["o.id"] = "id",
                ["ov.plate"] = "plate",
                ["IFNULL(u.profile_logo, 'https://i.imgur.com/YSXdYqv.png')"] = "profile_logo",
                ["IFNULL(CONCAT(JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname'))), 'Ukendt ejer')"] = "name",
                ["IFNULL(JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.phone')), 'Ukendt nummer')"] = "phone_number",
                ["ov.thumbnail"] = "thumbnail",
                ["ov.hash"] = "vehicle",
                ["o.offenses"] = "offenses",
                ["o.date"] = "date",
                ["o.officer_id"] = "officer_id",
                ["o.description"] = "description"
            },
            joins = {
                "LEFT JOIN player_vehicles ov ON (ov.plate = o.plate COLLATE utf8mb4_general_ci)",
                "LEFT JOIN apartments op ON (op.citizenid = ov.citizenid COLLATE utf8mb4_general_ci)",
                "LEFT JOIN players u ON (u.citizenid = ov.citizenid COLLATE utf8mb4_general_ci)"
            },
            where = "CONCAT(JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname'))) LIKE @name AND o.plate=ov.plate",
            extra = "GROUP BY o.plate LIMIT 0,30"
        },
        ["/vehicle_ansatte"] = {
            type = "SELECT_JOIN",
            table = "omik_polititablet_ansatte an",
            fields = {
                ["CONCAT(JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname')))"] = "name",
                ["an.officer_id"] = "officer_id",
                ["an.badge_number"] = "badge_number",
                ["an.profile_logo"] = "profile_logo"
            },
            joins = {"INNER JOIN players u ON u.officer_id = an.officer_id"}
        },
        ["/vehicle_find"] = {
            type = "SELECT_JOIN",
            table = "player_vehicles ov",
            fields = {
                ["ov.plate"] = "plate",
                ["ov.hash"] = "vehicle",
                ["CONCAT(JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.firstname')), ' ', JSON_UNQUOTE(JSON_EXTRACT(u.charinfo, '$.lastname')))"] = "name",
                ["u.profile_logo"] = "profile_logo",
                ["ov.thumbnail"] = "thumbnail"
            },
            joins = {"LEFT JOIN players u ON (u.citizenid = ov.citizenid COLLATE utf8mb4_general_ci)"},
            where = "ov.plate LIKE @plate",
            extra = "LIMIT 0,30"
        },
        ["/create"] = {
            type = "INSERT",
            table = "omik_polititablet_efterlysninger",
            table_cols = "(id, type, plate, identifier, description, offenses, officer_id, date)",
            insert_fields = "(NULL, @type, @plate, @identifier, @description, @offenses, @officer_id, CURRENT_TIMESTAMP())"
        },
        ["/edit_person"] = {
            type = "UPDATE",
            table = "omik_polititablet_efterlysninger ef",
            update_fields = {"ef.description = @description, ef.offenses = @offenses"},
            where = "ef.identifier = @identifier"
        },
        ["/edit_vehicle"] = {
            type = "UPDATE",
            table = "omik_polititablet_efterlysninger ef",
            update_fields = {"ef.description = @description, ef.offenses = @offenses"},
            where = "ef.plate = @plate"
        },
        ["/delete"] = {
            type = "DELETE",
            table = "omik_polititablet_efterlysninger",
            where = "id = @id"
        }
    }
}
