<html>
<body>
[% IF agent.is_docomo %]
i�⡼��
[% ELSIF agent.is_ezweb %]
EZweb
[% ELSIF agent.is_vodafone %]
Vodafone Live!
[% ELSE %]
Non Mobile...
[% END %]
</body>
</html>

