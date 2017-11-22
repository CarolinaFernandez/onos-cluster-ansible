#!/usr/bin/python

import re


class FilterModule(object):
    def filters(self):
        return {
            "get_dict_key": self.get_dict_key,
            "get_dict_value": self.get_dict_value,
            "get_dict_value_for_key": self.get_dict_value_for_key,
            "iface_in_target_node": self.iface_in_target_node,
            "ip_compute_subnet": self.ip_compute_subnet,
            "ip_strip_subnet": self.ip_strip_subnet,
        }

    def match_get_nth_group(self, reg_exp, data, nth):
        reg_match = re.match(reg_exp, str(data))
        if reg_match is not None and reg_match.groups >= (nth + 1):
            return reg_match.group(nth)
        return data

    def get_dict_key(self, data):
        reg_exp = "{(?:u')?(.*?)(?:')?: (?:u')?(.*?)(?:')?}"
        return self.match_get_nth_group(reg_exp, data, 1)

    def get_dict_value(self, data):
        reg_exp = "{(?:u')?(?:.*?)(?:')?: (?:u')?(.*?)(?:')?}"
        return self.match_get_nth_group(reg_exp, data, 1)

    def get_dict_value_for_key(self, data, key):
        reg_exp = "{(?:u')?%s(?:')?: (?:u')?(.*?)(?:')?}".replace("%s", key)
        if isinstance(data, list):
            data = data[0]
        return self.match_get_nth_group(reg_exp, data, 1)

    def iface_in_target_node(self, dict_nodes, target_ip, iface_ip):
        for node, ips in dict_nodes.iteritems():
            ips = str(ips["ip"])
            if target_ip in ips and iface_ip in ips:
                return True
        return False

    def ip_compute_subnet(self, data):
        reg_exp = "\\b(\d{1,3}.)(\d{1,3}.)(\d{1,3}.)(\d{1,3})\\b"
        return re.sub(reg_exp, "\\1\\2\\3*", data)

    def ip_strip_subnet(self, data):
        reg_exp = "(.*)\\/(?:.*)"
        return self.match_get_nth_group(reg_exp, data, 1)
