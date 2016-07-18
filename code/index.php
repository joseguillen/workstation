<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>Welcome to your Workstation</title>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">
    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
</head>

<body role="document">
    <?php
        // create a new cURL resource
        $ch = curl_init();
        // set URL and other appropriate options
        curl_setopt($ch, CURLOPT_URL, "http://icanhazip.com/");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_HEADER, 0);

        // grab URL and pass it to the browser
        $ipaddress = curl_exec($ch);
        // close cURL resource, and free up system resources

        curl_close($ch);
    ?>
    <div class="container theme-showcase" role="main">
        <div class="jumbotron">
            <h1>Hey, welcome to your Workstation!</h1>
            <p>This is your new development environment powered by Vagrant and DigitalOcean. Here you'll be able to work on your projects without having to worry about all the bootstap stuff.</p>
            <p>Your environment's ip address is <strong><?= $ipaddress; ?></strong></p>
        </div>

        <div class="page-header">
            <h1>First things first</h1>
        </div>
        <h2>Install Gasmask</h2>
        <p><a href="http://clockwise.ee/" target="_blank">Download gasmask</a> and create a new profile.</p>
        <p>Add the following line to it and activate it.</p>
        <pre><?= substr($ipaddress, 0, -1).' workstation.dev www.workstation.dev'; ?></pre>
        <p>Now you can access your workstation from <a href="http://www.workstation.dev">www.workstation.dev</a></p>
        <div class="page-header">
            <h1>Getting to Work</h1>
        </div>
        <p>Before anything, make sure that you are running the vagrant watch task <pre>vagrant rsync-auto</pre></p>
        <p>Anything in the /code directory will be synced to your virtual machine in DigitalOcean. Drop your project
            directory in the /code folder and configure your vhost (you can create your own or add one to workstation.conf).
            Here is a sample of it:
        </p>
        <pre>&lt;VirtualHost *:80&gt;
        ServerAdmin notifications@filamentlab.com
        ServerName your_project_url.dev
        ServerAlias www.your_project_url.dev
        DocumentRoot /var/www/your_project_dir
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
&lt;/VirtualHost&gt;</pre>
        <p>Once you've created you vhost, just added it to your hosts file like we did with worstation.dev and you're ready to go.</p>
        <div class="page-header">
            <h1>If you're using mysql...</h1>
        </div>
        <p>You will need to know that the mysql password is: <i>W04Abm9lLV0Xl47</i></p>
    </div> <!-- /container -->

</body>

</html>