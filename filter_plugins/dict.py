#!/usr/bin/python

import re


class FilterModule(object):
    def filters(self):
        return {
            "get_dict_key": self.get_dict_key,
            "get_dict_value": self.get_dict_value,
            "get_dict_value_for_key": self.get_dict_value_for_key,
        }

    def __match_get_nth_group(self, reg_exp, data, nth):
        reg_match = re.match(reg_exp, str(data))
        if reg_match is not None and reg_match.groups >= (nth + 1):
            return reg_match.group(nth)
        return data

    def get_dict_key(self, data):
        reg_exp = "{(?:u')?(.*?)(?:')?: (?:u')?(.*?)(?:')?}"
        return self.__match_get_nth_group(reg_exp, data, 1)

    def get_dict_value(self, data):
        reg_exp = "{(?:u')?(?:.*?)(?:')?: (?:u')?(.*?)(?:')?}"
        return self.__match_get_nth_group(reg_exp, data, 1)

    def get_dict_value_for_key(self, data, key):
        reg_exp = "{(?:u')?%s(?:')?: (?:u')?(.*?)(?:')?}".replace("%s", key)
        if isinstance(data, list):
            data = data[0]
        return self.__match_get_nth_group(reg_exp, data, 1)
