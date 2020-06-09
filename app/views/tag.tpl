<?php if (isLogged()) { ?>
    <?php $this->widget('Search');?>
    <?php $this->widget('Notification');?>
    <?php $this->widget('VisioLink');?>
    <?php $this->widget('Notifications');?>
    <?php $this->widget('SendTo');?>

    <nav class="color dark">
        <?php $this->widget('Presence');?>
        <?php $this->widget('Navigation');?>
    </nav>
<?php } ?>

<main style="background-color: var(--movim-background);">
    <?php if (isLogged()) { ?>
        <aside>
            <?php $this->widget('NewsNav');?>
        </aside>
    <?php } ?>
    <div>
        <?php $this->widget('Blog');?>
    </div>
</main>
