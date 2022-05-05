<html>
<body>
[% IF agent.is_docomo %]
i¥â¡¼¥É
[% ELSIF agent.is_ezweb %]
EZweb
[% ELSIF agent.is_vodafone %]
Vodafone Live!
[% ELSE %]
Non Mobile...
[% END %]
</body>
</html>

