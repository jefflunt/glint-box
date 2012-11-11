<a href="mailto:jefflunt@gmail.com">Report a problem</a> with one of the images.

## STABLE glint-nes downloads

*There are no stable releases yet. Please download a BETA image, try it out, and report back any issues you have.*

<hr />

## BETA glint-nes downloads

<table id="release-list">
  <thead>
    <tr>
      <th>Build date</th>
      <th>Problems</th>
      <th>Torrent</th>
      <th>Dowload</th>
      <th>Built from</th>
      <th>Size</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>2012-11-11</td>
      <td><img src="/storage/design/yellow-exclamation-15px.png" /> <a href="#2012-11-11-problems">Some keyboard issues :(</a></td>
      <td><a href="https://s3-us-west-2.amazonaws.com/glint-images/2012-11-11-glint-nes.torrent">torrent</a></td>
      <td><a href="https://s3-us-west-2.amazonaws.com/glint-images/2012-11-11-glint-nes.img.zip">download</a></td>
      <td>Raspbian 2012-10-28</td>
      <td>565 MB</td>
    </tr>

    <tr>
      <td>2012-11-05</td>
      <td><img src="/storage/design/yellow-exclamation-15px.png" /><a href="#2012-11-05-problems"> Limited audio issues. Most games working well.</a></td>
      <td><a href="https://s3-us-west-2.amazonaws.com/glint-images/2012-11-05-glint-nes.torrent">torrent</a></td>
      <td><a href="https://s3-us-west-2.amazonaws.com/glint-images/2012-11-05-glint-nes.img.zip">download</a></td>
      <td>Raspbian 2012-10-28</td>
      <td>535 MB</td>
    </tr>

    <tr>
      <td>2012-11-03</td>
      <td><a href="#2012-11-03-problems"><img src="/storage/design/yellow-exclamation-15px.png" /> Sound glitches on many games</a></td>
      <td><a href="https://s3-us-west-2.amazonaws.com/glint-images/2012-11-03-glint-nes.torrent">torrent</a></td>
      <td><a href="https://s3-us-west-2.amazonaws.com/glint-images/2012-11-03-glint-nes.img.zip">download</a></td>
      <td>Raspbian 2012-10-28</td>
      <td>500 MB</td>
    </tr>
    
    <tr>
      <td>2012-11-02</td>
      <td><a href="#2012-11-02-problems"><img src="/storage/design/red-exclamation-15px.png" /> Won't boot</a></td>
      <td>REMOVED</td>
      <td>REMOVED</td>
      <td>Raspbian 2012-09-18</td>
      <td>2 GB</td>
    </tr>
    
    <tr>
      <td>2012-11-01</td>
      <td><a href="#2012-11-01-problems"><img src="/storage/design/red-exclamation-15px.png" /> Won't boot</a></td>
      <td>REMOVED</td>
      <td>REMOVED</td>
      <td>Raspbian 2012-09-18</td>
      <td>8 GB</td>
    </tr>
  </tbody>
</table>

<hr />

### Notes for BETA 2012-11-11-glint-nes image
<table id="2012-11-11-problems" class="release-problems">
  <tbody>
    <td></td>
    <td>
      <ul class="compact-list">
        <li>Auto-login of "pi" user - not password is required any longer</li>
        <li><img src="/storage/design/yellow-exclamation-15px.png" /> Keyboard seems to be disabled during emulation :( You have to press Ctrl+Alt+Del to gracefully shutdown the Pi to load another game</li>
        <ul>
          <li>This seems to be a side effect of the auto-login feature recently added. I'm working to correct this.</li>
        </ul>
        <li>SSH server is disabled</li>
        <li>US English default keyboard layout is enabled (you must change this if you do not use a US keyboard)</li>
        <li>Even more games working well. See updated <a href="http://karmanebula.com/game-support">game support list</a></li>
        <li>Currently being tested. Please download, experiment, and report back.</li>        
      </ul>
    </td>
  </tbody>
</table>


### Notes for BETA 2012-11-05-glint-nes image
<table id="2012-11-05-problems" class="release-problems">
  <tbody>
    <td></td>
    <td>
      <ul class="compact-list">
        <li>Many audio issues resolved. See updated <a href="http://karmanebula.com/game-support">game support list</a></li>
        <li>Full speed emulation for most games</li>
        <li><img src="/storage/design/yellow-exclamation-15px.png" /> Limited audio issues. Most games working well.</li>        
      </ul>
    </td>
  </tbody>
</table>

### Notes for BETA 2012-11-03-glint-nes image
<table id="2012-11-03-problems" class="release-problems">
  <tbody>
    <td></td>
    <td>
      <ul class="compact-list">
        <li>Had to stop and restart retroarch twice to get FCEU to work at full speed. Might have been a fluke.</li>
        <li>Full speed emulation for most games</li>
        <li><img src="/storage/design/yellow-exclamation-15px.png" /> Many games with <u><strong>minor</strong></u> to <u><strong>extreme audio pops/glitches</strong></u>, and some performance problems.
        <li>Successfully images to 2GB or larger SD card</li>
      </ul>
    </td>
  </tbody>
</table>

### Notes for BETA 2012-11-02-glint-nes image
<table id="2012-11-02-problems" class="release-problems">
  <tbody>
    <td><img src="/storage/design/red-exclamation-15px.png" /></td>
    <td>Raspberry Pi doesn't successfully boot from this image.</td>
  </tbody>
</table>
<br />

### Notes for BETA 2012-11-01-glint-nes image
<table id="2012-11-01-problems" class="release-problems">
  <tbody>
    <td><img src="/storage/design/red-exclamation-15px.png" /></td>
    <td>Raspberry Pi doesn't successfully boot from this image.</td>
  </tbody>
</table>